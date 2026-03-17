local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- Configura tu motor de snippets (ej. luasnip)
  },
  mapping = cmp.mapping.preset.insert({
    -- Tus atajos de teclado
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Aceptar sugerencia
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- <--- ¡LA FUENTE DEL LSP ES CLAVE!
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
  -- Asegúrate de tener configurado el mapping para mostrar sugerencias
  mapping = cmp.mapping.preset.insert({
    -- ... otros mappings ...
    ['<C-Space>'] = cmp.mapping.complete(),  -- Para forzar completado manual
  }),
  
  -- La fuente LSP debe estar presente
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- Esta es la fuente del LSP
    { name = 'buffer' },
    { name = 'path' },
  }),
  
  -- Para mejorar el completado con caracteres especiales como '{' y ':'
  completion = {
    keyword_length = 1,  -- Comienza a sugerir después de 1 carácter
    keyword_pattern = [[\k\+]],  -- Permite más caracteres en las palabras clave
  },
  formatting = {
    -- Define cómo se muestran los campos en el menú de completado
    format = function(entry, vim_item)
      -- Fuente de donde viene la sugerencia (LSP, buffer, path, etc.)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      
      -- Esto debería mostrar el contenido real de la sugerencia
      return vim_item
    end,
  },
})
