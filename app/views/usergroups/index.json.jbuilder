json.array!(@usergroups) do |usergroup|
  json.extract! usergroup, :id, :admin_id, :name
  json.url usergroup_url(usergroup, format: :json)
end
