export const createPledge = (total_amount) => (
  $.ajax({
    method: "POST",
    url: `api/projects`,
    data:  { total_amount }
  })
);
