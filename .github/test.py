import yaml
with open ('test.yaml','r') as stream:
  yaml_content=yaml.safe_load(file)
  if 'value' in value:
    for key, value in value['value'].items():
      print(f"{key}: {value}")
