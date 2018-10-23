json.partial! 'api/projects/project', project: @project

json.likes @project.likes.count
