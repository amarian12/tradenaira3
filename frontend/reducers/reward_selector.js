export const rewardsByProject = (rewards, projectId) => {
  const rewardArray = Object.values(rewards);
  const filteredRewards = rewardArray.filter(e=> e.project_id === parseInt(projectId));
  return filteredRewards;
}
