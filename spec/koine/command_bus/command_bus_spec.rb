require "spec_helper"

describe Koine::CommandBus::CommandBus do
  subject do
    Koine::CommandBus::CommandBus.new([
      DummyApp::CommandResolver.new
    ])
  end

  describe "#handle" do
    it "throws an exception when no handler is found" do
      begin
        command_class = DummyApp::Command::NotHandlable
        subject.handle(command_class.new(:foo))

        fail
      rescue Koine::CommandBus::CommandBus::UnhandledCommandError => e
        e.message.must_equal "Command '#{command_class}' could not be handled"
      end
    end

    it "handles command" do
      hello_command = DummyApp::Command::Hello.new(:foo)
      good_bye_command = DummyApp::Command::GoodBye.new(:bar)

      subject.handle(hello_command).must_equal "hello foo"
      subject.handle(good_bye_command).must_equal "good bye bar"
    end
  end

  describe "#initialize" do
    it "takes resolvers as arguments" do
      subject = Koine::CommandBus::CommandBus.new([
        DummyApp::CommandResolver.new
      ])

      subject.resolvers.count.must_equal 1
    end

    it "defaults to empty array" do
      Koine::CommandBus::CommandBus.new.resolvers.count.must_equal 0
    end
  end
end
