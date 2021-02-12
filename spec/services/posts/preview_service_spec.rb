require 'rails_helper'

RSpec.describe Posts::PreviewService, type: :service do
  describe '#data' do
    context 'valid URL' do
      it 'returns data' do
        stub_request(:get, /github.com/).to_return(status: 200, body: %(
          <html>
            <head>
              <title>Github</title>
              <meta name="description" content="#1 Open Source Repositories">
              <meta property="og:image" content="https://github.githubassets.com/images/modules/logos_page/Octocat.png">
            </head>
          </html>
        ))

        data = described_class.new('github.com').data

        expect(data[:title]).to eq 'Github'
        expect(data[:body]).to eq '#1 Open Source Repositories'
        expect(data[:image]).to eq 'https://github.githubassets.com/images/modules/logos_page/Octocat.png'
        expect(data[:url]).to eq 'http://github.com/'
      end
    end

    context 'invalid URL' do
      it 'responds with not found' do
        data = described_class.new(nil).data

        expect(data[:url]).to eq ''
      end
    end
  end
end
