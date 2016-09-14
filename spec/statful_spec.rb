require 'spec_helper'
require 'logger'
require 'stringio'
require 'statful-client'

describe StatfulAspects do
  describe '#initialize' do
    it 'should store statful client' do
      statful_client = Minitest::Mock.new
      statful_client.expect(:nil?, false)
      statful_aspects = StatfulAspects.new(statful_client)

      wont_be_nil(statful_aspects.statful_client)
    end

    it 'should raise ArgumentError if statful is missing' do
      begin
        StatfulAspects.new(nil)
      rescue => ex
        ex.must_be_kind_of ArgumentError
      end
    end
  end

  describe '#timer' do
    it 'it should not tamper with caller method output' do
      class TestClassOutput
        def test_method
          'statful'
        end
      end

      test_class = TestClassOutput.new

      log = StringIO.new
      statful_client = StatfulClient.new({'transport' => 'udp',
                                          'dryrun' => true,
                                          'logger' => Logger.new(log),
                                          'flush_size' => 1
                                         })

      statful_aspects = StatfulAspects.new(statful_client)
      statful_aspects.timer(TestClassOutput, 'test_method', 'metric', {})

      output = test_class.test_method
      output.must_equal('statful')
    end

    it 'it should call client timer with correct arguments' do
      class TestClassTimer
        def test_method
          'statful'
        end
      end

      test_class = TestClassTimer.new

      statful_client = Minitest::Mock.new
      statful_client.expect(:nil?, false)
      statful_client.expect :timer, true, ['metric', Float, {:tags => {:key => 'value'}}]

      statful_aspects = StatfulAspects.new(statful_client)
      statful_aspects.timer(TestClassTimer, 'test_method', 'metric', {:tags => {:key => 'value'}})

      test_class.test_method
      statful_client.verify
    end
  end
end
