require 'rails_helper'

RSpec.describe Sendgrid::MailerService, type: :service do
  context '#initialize' do
    it 'sets @sg' do
      instance = described_class.new('template', 'from@example.com')
      expect(instance.instance_variable_get(:@sg)).not_to eq(nil)
    end

    it 'sets @mail' do
      instance = described_class.new('template', 'from@example.com')
      expect(instance.instance_variable_get(:@mail)).not_to eq(nil)
      expect(instance.instance_variable_get(:@mail).class).to eq(SendGrid::Mail)
    end

    context 'template is blank' do
      it 'raises an error' do
        expect { described_class.new(nil, 'from@example.com') }
          .to raise_error('Template can\'t be blank')
      end
    end

    context 'email is blank' do
      it 'raises an error' do
        expect { described_class.new('template', nil) }
          .to raise_error('From can\'t be blank')
      end
    end
  end

  context '#add_personalization' do
    it 'adds the personalization' do
      instance = described_class.new('template', 'from@example.com')
      instance.add_personalization(to: 'to@example.com', data: { k: 'v' })

      personalizations = instance.instance_variable_get(:@mail).personalizations
      expect(personalizations).not_to be_empty

      personalization = personalizations.last
      expect(personalization['to'].first['email']).to eq('to@example.com')
      expect(personalization['dynamic_template_data']).to eq({ 'k' => 'v' })
    end

    context 'to is blank' do
      it 'raises an error' do
        instance = described_class.new('template', 'from@example.com')
        expect { instance.add_personalization }
          .to raise_error('To can\'t be blank')
      end
    end
  end

  context '#add_attachment' do
    let(:file) { file_fixture('logo.png') }

    it 'adds the attachment' do
      instance = described_class.new('template', 'from@example.com')
      instance.add_attachment(name: 'Name', file: file)

      attachments = instance.instance_variable_get(:@mail).attachments
      expect(attachments).not_to be_empty

      attachment = attachments.last
      expect(attachment['filename']).to eq 'Name'
      expect(attachment['content']).not_to eq nil
    end

    context 'name is blank' do
      it 'raises an error' do
        instance = described_class.new('template', 'from@example.com')
        expect { instance.add_attachment(name: nil, file: file) }
          .to raise_error('Name can\'t be blank')
      end
    end

    context 'file is blank' do
      it 'raises an error' do
        instance = described_class.new('template', 'from@example.com')
        expect { instance.add_attachment(name: 'Name', file: nil) }
          .to raise_error('File can\'t be blank')
      end
    end
  end

  context '#reply_to=' do
    it 'sets the reply_to value' do
      instance = described_class.new('template', 'from@example.com')
      instance.reply_to = 'reply_to@example.com'

      reply_to = instance.instance_variable_get(:@mail).reply_to
      expect(reply_to['email']).to eq 'reply_to@example.com'
    end
  end

  context '#deliver' do
    it 'makes the api request' do
      instance = described_class.new('template', 'from@example.com')
      instance.add_personalization(to: 'to@example.com', data: {})

      stub_request(:post, /api.sendgrid.com/).to_return(status: 204)
      instance.deliver
    end

    context 'without personalizations' do
      it 'raises an error' do
        instance = described_class.new('template', 'from@example.com')

        expect { instance.deliver }
          .to raise_error('Personalizations can\'t be blank')
      end
    end
  end
end
