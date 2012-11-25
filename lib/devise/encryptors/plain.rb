module Devise
  module Encryptable
    module Encryptors
      class Plain < Base
        def self.digest(password, stretches, salt, pepper)
          password
        end
      end
    end
  end
end