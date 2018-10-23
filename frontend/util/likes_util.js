export const fetchAllLikes = () => (
  $.ajax({
    method: "GET",
    url: "api/projects"
  })
)
