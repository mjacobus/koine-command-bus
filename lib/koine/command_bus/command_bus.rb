module Koine
  module CommandBus
    class CommandBus
      UnhandledCommandError = Class.new(RuntimeError)

      attr_reader :resolvers

      def initialize(resolvers = [])
        @resolvers = resolvers
      end

      def handle(command)
        handler_for(command).handle(command)
      end

      def handler_for(command)
        resolvers.each do |resolver|
          handler = resolver.resolve(command)
          return handler if handler
        end

        raise UnhandledCommandError, "Command '#{command.class}' could not be handled"
      end
    end
  end
end
