module DummyApp
  module Command
    Hello        = Struct.new(:name)
    GoodBye      = Struct.new(:name)
    NotHandlable = Struct.new(:name)
  end
end

module DummyApp
  module CommandHandler
    class Hello
      def handle(command)
        "hello #{command.name}"
      end
    end

    class GoodBye
      def handle(command)
        "good bye #{command.name}"
      end
    end
  end
end

module DummyApp
  class CommandResolver
    def resolve(command)
      if command.is_a?(Command::Hello)
        return CommandHandler::Hello.new
      end

      if command.is_a?(Command::GoodBye)
        return CommandHandler::GoodBye.new
      end
    end
  end
end
