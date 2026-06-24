// Emoji 鍵盤 - 基於符號表樣式
// 使用與 symbolic_portrait 相同的佈局和樣式，但調整內容區域的列數和行數

local collectionData = import '../lib/collectionData.libsonnet';
local symbolic = import './symbolic_portrait.jsonnet';

local keyboard(theme) =
  symbolic.new(theme, kbTypePrefix='emoji') + {
    // 覆蓋右側內容列表設定，添加 maxColumns 和 maxRows
    descriptionCollection+: {
      maxColumns: 5,
      maxRows: 4,
    },
  };

{
  new(theme):
    keyboard(theme) + collectionData.emojiDataSource,
}
