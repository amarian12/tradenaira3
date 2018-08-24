module Private
  module Deposits
    class NairasController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlBankable
    end
  end
end
