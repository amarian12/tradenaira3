# json.partial! 'api/pledges/pledge', pledge: @pledge

json.extract! @pledge, :amount_pledged
