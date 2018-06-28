require "rails_helper"

RSpec.describe ImagesController do
  describe '#create' do
    it 'creates an images' do
      post images_path
      expect(response).to be_created
    end
  end
end
