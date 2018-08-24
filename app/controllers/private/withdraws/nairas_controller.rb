module Private::Withdraws
  class NairasController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
