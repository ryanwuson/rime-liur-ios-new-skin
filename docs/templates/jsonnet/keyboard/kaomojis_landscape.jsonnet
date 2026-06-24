// Kaomojis 鍵盤（橫向）- 基於符號表樣式
local collectionData = import '../lib/collectionData.libsonnet';
local symbolic = import './symbolic_landscape.jsonnet';

local kaomojiData = collectionData.kaomojisDataSource;

local keyboard(theme) =
  symbolic.new(theme, kbTypePrefix='kaomojis') + {
    // 覆蓋分類列表
    category: collectionData.kaomojisCategory,
    // 隱藏「全」字標記（badge）- 設為透明色
    descriptionCollectionCellForegroundStyle+: {
      badgeNormalColor: '00000000',
      badgeHighlightColor: '00000000',
    },
    // 覆蓋各分類數據
    '常用': kaomojiData['常用'],
    '微笑': kaomojiData['微笑'],
    '開心': kaomojiData['開心'],
    '加油': kaomojiData['加油'],
    '失望': kaomojiData['失望'],
    '哭哭': kaomojiData['哭哭'],
    '哦哦': kaomojiData['哦哦'],
    '氣氣': kaomojiData['氣氣'],
    '其他': kaomojiData['其他'],
    '動作': kaomojiData['動作'],
    '動物': kaomojiData['動物'],
    '符號': kaomojiData['符號'],
    '手手': kaomojiData['手手'],
    '眼睛': kaomojiData['眼睛'],
    '鼻子': kaomojiData['鼻子'],
    '嘴巴': kaomojiData['嘴巴'],
    '臉頰': kaomojiData['臉頰'],
    // 移除「全」字標記
    descriptionCollection+: {
      displayVariant: false,
    },
  };

{
  new(theme): keyboard(theme),
}
