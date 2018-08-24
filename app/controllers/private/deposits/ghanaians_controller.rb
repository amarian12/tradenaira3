module Private
	module Deposits
        class GhanaiansController < ::Private::Deposits::BaseController
      		include ::Deposits::CtrlBankable
        end
    end
end