module Private
  module Deposits
    class EurosController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlBankable
    end
  end
end
