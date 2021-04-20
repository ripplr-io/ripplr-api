require 'rails_helper'

RSpec.describe LinkPreview, type: :wrapper do
  describe '.fetch' do
    context 'valid URL' do
      it 'returns data' do
        stub_request(:get, /api.linkpreview.net/).to_return(status: 200, body: {
          title: 'Github',
          description: '#1 Open Source Repositories',
          image: 'https://github.githubassets.com/images/modules/logos_page/Octocat.png',
          url: 'http://github.com/'
        }.to_json)

        data = described_class.fetch('github.com')

        expect(data[:title]).to eq 'Github'
        expect(data[:body]).to eq '#1 Open Source Repositories'
        expect(data[:image]).to eq 'https://github.githubassets.com/images/modules/logos_page/Octocat.png'
        expect(data[:url]).to eq 'http://github.com/'
      end
    end

    context 'invalid URL' do
      it 'responds with not found' do
        stub_request(:get, /api.linkpreview.net/).to_return(status: 422)

        data = described_class.fetch(nil)

        expect(data[:url]).to eq ''
      end
    end
  end
end
