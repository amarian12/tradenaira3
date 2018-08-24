module Private
  module Deposits
    class BtcsController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlBankable
    end
  end
end
