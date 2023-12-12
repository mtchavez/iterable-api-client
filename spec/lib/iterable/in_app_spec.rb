# typed: false

require 'spec_helper'

RSpec.describe Iterable::InApp, :vcr do
  let(:resp_body) { res.body }

  describe 'messages_for_email' do
    let(:email) { 'danny@appleuniversity.com' }
    let(:res) { subject.messages_for_email(email) }
    let(:messages) { resp_body['inAppMessages'] }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns messages' do
        expect(messages).to be_a(Array)
        expect(messages.size).to eq(1)
      end
    end
  end

  describe 'messages_for_user_id' do
    let(:user_id) { 84_097 }
    let(:res) { subject.messages_for_user_id(user_id) }
    let(:messages) { resp_body['inAppMessages'] }

    context 'when successful' do
      it 'responds with success' do
        expect(res).to be_success
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns messages' do
        expect(messages).to be_a(Array)
        expect(messages.size).to eq(1)
      end
    end
  end

  describe 'target' do
    let(:email) { 'home@gmail.com' }
    let(:campaign_id) { 4_572_825 }
    let(:res) { subject.target email: email, campaign_id: campaign_id }

    context 'when successful' do
      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'returns success code' do
        expect(res.body['code']).to match(/success/i)
      end
    end

    context 'without email' do
      let(:email) { '' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end

    context 'without campaign ID' do
      let(:campaign_id) { '' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end

    context 'with invalid email' do
      let(:email) { 'foo@' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
        expect(res.body['code']).to match(/InvalidEmailAddressError/i)
      end
    end

    context 'with invalid campaign Id' do
      let(:campaign_id) { 4_444 }
      let(:email) { 'home@gmail.com' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
        expect(res.body['msg']).to match(/Invalid campaign Id/i)
      end
    end

    context 'with campaign ID and user email' do
      let(:campaign_id) { 4_572_825 }
      let(:email) { 'home@gmail.com' }

      it 'successful' do
        expect(res.body['code']).to match(/success/i)
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end
    end

    context 'with User Email, campaign ID, and more data' do
      let(:campaign_id) { 4_572_825 }
      let(:params) do
        { sendAt: Time.now.localtime + 864_000, data_fields: { first_name: 'Chester',
                                                               last_name: 'Tester' } }
      end
      let(:email) { 'home@gmail.com' }
      let(:res) { subject.target email: email, campaign_id: campaign_id, attrs: params }

      it 'successful' do
        expect(res.body['code']).to match(/success/i)
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'has proper scheduled message id param' do
        expect(res.body['params']).to include('scheduledMessageId')
      end
    end

    context 'with campaign ID and User ID' do
      let(:campaign_id) { 4_572_825 }
      let(:params) { { recipientUserId: '84097' } }
      let(:res) { subject.target campaign_id: campaign_id, attrs: params }

      it 'successful' do
        expect(res.body['code']).to match(/success/i)
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end
    end

    context 'with campaign ID, User ID, and more data' do
      let(:campaign_id) { 4_572_825 }
      let(:params) do
        { recipientUserId: '84097', sendAt: Time.now.localtime + 86_400,
          dataFields: { firstName: 'Chester', lastName: 'Tester' } }
      end
      let(:res) { subject.target campaign_id: campaign_id, attrs: params }

      it 'successful' do
        expect(res.body['code']).to match(/success/i)
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end

      it 'has proper scheduled message id param' do
        expect(res.body['params']).to include('scheduledMessageId')
      end
    end
  end

  describe 'cancel' do
    let(:email) { 'danny@appleuniversity.com' }
    let(:campaign_id) { 4_572_825 }
    let(:res) { subject.cancel email: email, campaign_id: campaign_id }

    before do
      in_app = described_class.new
      in_app.target(email: 'danny@appleuniversity.com', campaign_id: 4_572_825,
                    attrs: { sendAt: Time.now.localtime + 86_400,
                             dataFields: { firstName: 'Chester', lastName: 'Tester' } })
    end

    context 'with User Email and campaign ID' do
      it 'successful' do
        expect(res.body['code']).to match(/success/i)
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end
    end

    context 'without email and without scheduled message Id' do
      let(:email) { '' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end
    end

    describe 'with campaign ID and User ID' do
      let(:params) { { userId: '84097' } }
      let(:res) { subject.cancel campaign_id: campaign_id, attrs: params }

      it 'successful' do
        expect(res.body['code']).to match(/success/i)
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end
    end

    context 'with Scheduled message Id' do
      let(:message_id) do
        described_class.new.target(email: 'danny@appleuniversity.com', campaign_id: 4_572_825,
                                   attrs: { sendAt: Time.now.localtime + 86_400,
                                            dataFields: { firstName: 'Chester',
                                                          lastName: 'Tester' } }).body['params']['scheduledMessageId']
      end
      let(:params) { { scheduledMessageId: message_id } }
      let(:res) { subject.cancel attrs: params }

      it 'successful' do
        expect(res.body['code']).to match(/success/i)
      end

      it 'responds with response object' do
        expect(res).to be_a(Iterable::Response)
      end
    end

    context 'with invalid campaign ID' do
      let(:campaign_id) { 44_444 }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end

      it 'has correct error message' do
        expect(res.body['msg']).to match(/No scheduled messages found- Invalid email and campaignId combination/i)
      end
    end

    context 'with invalid User Email' do
      let(:email) { 'foo@' }

      it 'is not successful' do
        expect(res).not_to be_success
      end

      it 'responds with an error code' do
        expect(res.code).to eq('400')
      end

      it 'has correct error message' do
        expect(res.body['code']).to match(/InvalidEmailAddressError/i)
      end
    end
  end
end
