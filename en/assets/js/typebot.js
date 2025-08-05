const typebotInitScript = document.createElement("script");

typebotInitScript.type = "module";
typebotInitScript.innerHTML = `import Typebot from 'https://cdn.jsdelivr.net/npm/@typebot.io/js@0.2/dist/web.js'
Typebot.initStandard({ typebot: "${document.currentScript.getAttribute('id')}" });
`;
document.body.append(typebotInitScript);