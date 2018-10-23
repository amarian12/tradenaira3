export const fetchRewards = (projectId) => (
  $.ajax({
    method: "GET",
    url: `api/rewards?id=${projectId}`
  })
)

export const createReward = (reward) => (
  $.ajax({
    method: "POST",
    url: `api/rewards`,
    data: { reward }
  })
)

export const updateReward = (reward) => (
  $.ajax({
    method: "PATCH",
    url: `api/rewards/${reward.id}`,
    data: { reward }
  })
)

// export const deleteReward = (rewardId) => (
//   $.ajax({
//     method: "DELETE",
//     url: `api/projects/:projectId/${rewardId}`
//   })
// )
