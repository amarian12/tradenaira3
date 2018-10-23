export const projectSelector = ({ projects }, id) => {
  const project = projects.id;
  return project ? project : null;
}
