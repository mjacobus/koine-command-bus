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
      handler_class(command).new
    rescue
      nil
    end

    def handler_class(command)
      klass = command.class.to_s.gsub("Command", "CommandHandler")
      Object.const_get(klass)
    end
  end
end
