require 'rails_helper'

RSpec.describe EmailPrefixer::Configuration do
  before do
    EmailPrefixer.configuration.application_name = 'MyApp'
  end

  describe EmailPrefixer::Configuration::DEFAULT_BUILDER do
    describe '#call' do
      subject { EmailPrefixer::Configuration::DEFAULT_BUILDER.call }
      context 'when stage_name == production' do
        before do
          EmailPrefixer.configuration.stage_name = 'production'
        end
        it { is_expected.to eq '[MyApp] ' }
      end
      context 'when stage_name != production' do
        before do
          EmailPrefixer.configuration.stage_name = 'staging'
        end
        it { is_expected.to eq '[MyApp STAGING] ' }
      end
    end
  end
end
