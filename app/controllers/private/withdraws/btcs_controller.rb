module Private::Withdraws
  class BtcsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
