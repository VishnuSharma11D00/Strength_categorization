version: 1
frontend:
  phases:
    build:
      commands:
        - echo "Building index.html"
        - sed -i 's|API_GATEWAY_URL_PLACEHOLDER|${API_GATEWAY_URL_root}|g' index.html
        - sed -i 's|API_GATEWAY_URL_PLACEHOLDER|${API_GATEWAY_URL_root}|g' History.html
        - mkdir dist
        - cp index.html dist/
        - cp History.html dist/
  artifacts:
    baseDirectory: dist
    files:
      - '**/*'
