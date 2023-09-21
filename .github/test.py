import yaml
with open ('test.yaml','r') as file:
  yaml_content=yaml.safe_load(file)
data=yaml_content['values']
for key, value in data.items()
    print(f'{key}: {value}')
