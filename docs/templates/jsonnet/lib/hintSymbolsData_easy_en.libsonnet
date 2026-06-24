// easy_en 鍵盤的長按符號數據
// 與 hintSymbolsData.alphabetic 相同，唯一差異：
//   字母鍵 a/A 等用 { character: 'x' }，讓輸入進入 Rime 緩衝區
//   變化形 ā/Ā 等保留 { sendKeys: '``a' }，與拼音鍵盤寫法一致，待方案端支援後自動生效
//   計算 d 鍵保留 { sendKeys: 'Control+equal' }，同上
local settings = import '../Settings.libsonnet';

local transformKey(keyData) =
  if settings.longPressLayout == '2' && std.objectHas(keyData, 'list') && std.length(keyData.list) >= 4 then
    local origList = keyData.list;
    // 將 1號與0號互換，3號與2號互換
    local newList = [origList[1], origList[0], origList[3], origList[2]] + origList[4:];
    keyData { list: newList }
  else
    keyData;

local transformKeyboard(kbData) =
  {
    [k]: if std.length(k) == 1 then transformKey(kbData[k]) else kbData[k]
    for k in std.objectFields(kbData)
  };

local baseData = {
  alphabetic: {
    // 第一排 Q~P
    q: {
      selectedIndex: 0,
      list: [
        { action: { character: 'q' }, label: { text: 'q' } },
        { action: { character: 'Q' }, label: { text: 'Q' } },
        { action: { sendKeys: '``q' }, label: { text: 'ɋ' } },
        { action: { sendKeys: '``Q' }, label: { text: 'Ɋ' } },
      ],
    },
    w: {
      selectedIndex: 0,
      list: [
        { action: { character: 'w' }, label: { text: 'w' } },
        { action: { character: 'W' }, label: { text: 'W' } },
        { action: { sendKeys: '``w' }, label: { text: 'ẁ' } },
        { action: { sendKeys: '``W' }, label: { text: 'Ẁ' } },
      ],
    },
    e: {
      selectedIndex: 0,
      list: [
        { action: { character: 'e' }, label: { text: 'e' } },
        { action: { character: 'E' }, label: { text: 'E' } },
        { action: { sendKeys: '``e' }, label: { text: 'ē' } },
        { action: { sendKeys: '``E' }, label: { text: 'Ē' } },
      ],
    },
    r: {
      selectedIndex: 0,
      list: [
        { action: { character: 'r' }, label: { text: 'r' } },
        { action: { character: 'R' }, label: { text: 'R' } },
        { action: { sendKeys: '``r' }, label: { text: 'ŕ' } },
        { action: { sendKeys: '``R' }, label: { text: 'Ŕ' } },
      ],
    },
    t: {
      selectedIndex: 0,
      list: [
        { action: { character: 't' }, label: { text: 't' } },
        { action: { character: 'T' }, label: { text: 'T' } },
        { action: { sendKeys: '``t' }, label: { text: 'ṫ' } },
        { action: { sendKeys: '``T' }, label: { text: 'Ṫ' } },
      ],
    },
    y: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``Y' }, label: { text: 'Ȳ' } },
        { action: { sendKeys: '``y' }, label: { text: 'ȳ' } },
        { action: { character: 'Y' }, label: { text: 'Y' } },
        { action: { character: 'y' }, label: { text: 'y' } },
      ],
    },
    u: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``U' }, label: { text: 'Ū' } },
        { action: { sendKeys: '``u' }, label: { text: 'ū' } },
        { action: { character: 'U' }, label: { text: 'U' } },
        { action: { character: 'u' }, label: { text: 'u' } },
      ],
    },
    i: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``I' }, label: { text: 'Ī' } },
        { action: { sendKeys: '``i' }, label: { text: 'ī' } },
        { action: { character: 'I' }, label: { text: 'I' } },
        { action: { character: 'i' }, label: { text: 'i' } },
      ],
    },
    o: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``O' }, label: { text: 'Ō' } },
        { action: { sendKeys: '``o' }, label: { text: 'ō' } },
        { action: { character: 'O' }, label: { text: 'O' } },
        { action: { character: 'o' }, label: { text: 'o' } },
      ],
    },
    p: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``P' }, label: { text: 'Ṕ' } },
        { action: { sendKeys: '``p' }, label: { text: 'ṕ' } },
        { action: { character: 'P' }, label: { text: 'P' } },
        { action: { character: 'p' }, label: { text: 'p' } },
      ],
    },

    // 第二排 A~L
    a: {
      selectedIndex: 0,
      list: [
        { action: { character: 'a' }, label: { text: 'a' } },
        { action: { character: 'A' }, label: { text: 'A' } },
        { action: { sendKeys: '``a' }, label: { text: 'ā' } },
        { action: { sendKeys: '``A' }, label: { text: 'Ā' } },
      ],
    },
    s: {
      selectedIndex: 0,
      list: [
        { action: { character: 's' }, label: { text: 's' } },
        { action: { character: 'S' }, label: { text: 'S' } },
        { action: { sendKeys: '``s' }, label: { text: 'ś' } },
        { action: { sendKeys: '``S' }, label: { text: 'Ś' } },
      ],
    },
    d: {
      selectedIndex: 0,
      list: [
        { action: { character: 'd' }, label: { text: 'd' } },
        { action: { character: 'D' }, label: { text: 'D' } },
        { action: { sendKeys: '``d' }, label: { text: 'ḋ' } },
        { action: { sendKeys: '``D' }, label: { text: 'Ḋ' } },
        { action: { sendKeys: 'Control+equal' }, label: { text: '計算' }, fontSize: 14 },
      ],
    },
    f: {
      selectedIndex: 0,
      list: [
        { action: { character: 'f' }, label: { text: 'f' } },
        { action: { character: 'F' }, label: { text: 'F' } },
        { action: { sendKeys: '``f' }, label: { text: 'ḟ' } },
        { action: { sendKeys: '``F' }, label: { text: 'Ḟ' } },
      ],
    },
    g: {
      selectedIndex: 0,
      list: [
        { action: { character: 'g' }, label: { text: 'g' } },
        { action: { character: 'G' }, label: { text: 'G' } },
        { action: { sendKeys: '``g' }, label: { text: 'ḡ' } },
        { action: { sendKeys: '``G' }, label: { text: 'Ḡ' } },
      ],
    },
    h: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``H' }, label: { text: 'Ḣ' } },
        { action: { sendKeys: '``h' }, label: { text: 'ḣ' } },
        { action: { character: 'H' }, label: { text: 'H' } },
        { action: { character: 'h' }, label: { text: 'h' } },
      ],
    },
    j: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``J' }, label: { text: 'Ĵ' } },
        { action: { sendKeys: '``j' }, label: { text: 'ĵ' } },
        { action: { character: 'J' }, label: { text: 'J' } },
        { action: { character: 'j' }, label: { text: 'j' } },
      ],
    },
    k: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``K' }, label: { text: 'Ḱ' } },
        { action: { sendKeys: '``k' }, label: { text: 'ḱ' } },
        { action: { character: 'K' }, label: { text: 'K' } },
        { action: { character: 'k' }, label: { text: 'k' } },
      ],
    },
    l: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``L' }, label: { text: 'Ĺ' } },
        { action: { sendKeys: '``l' }, label: { text: 'ĺ' } },
        { action: { character: 'L' }, label: { text: 'L' } },
        { action: { character: 'l' }, label: { text: 'l' } },
      ],
    },

    // 第三排 Z~M
    z: {
      selectedIndex: 0,
      list: [
        { action: { character: 'z' }, label: { text: 'z' } },
        { action: { character: 'Z' }, label: { text: 'Z' } },
        { action: { sendKeys: '``z' }, label: { text: 'ź' } },
        { action: { sendKeys: '``Z' }, label: { text: 'Ź' } },
      ],
    },
    x: {
      selectedIndex: 0,
      list: [
        { action: { character: 'x' }, label: { text: 'x' } },
        { action: { character: 'X' }, label: { text: 'X' } },
        { action: { sendKeys: '``x' }, label: { text: 'ẋ' } },
        { action: { sendKeys: '``X' }, label: { text: 'Ẋ' } },
      ],
    },
    c: {
      selectedIndex: 0,
      list: [
        { action: { character: 'c' }, label: { text: 'c' } },
        { action: { character: 'C' }, label: { text: 'C' } },
        { action: { sendKeys: '``c' }, label: { text: 'ć' } },
        { action: { sendKeys: '``C' }, label: { text: 'Ć' } },
      ],
    },
    v: {
      selectedIndex: 0,
      list: [
        { action: { character: 'v' }, label: { text: 'v' } },
        { action: { character: 'V' }, label: { text: 'V' } },
        { action: { sendKeys: '``v' }, label: { text: 'ṽ' } },
        { action: { sendKeys: '``V' }, label: { text: 'Ṽ' } },
      ],
    },
    b: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``B' }, label: { text: 'Ḃ' } },
        { action: { sendKeys: '``b' }, label: { text: 'ḃ' } },
        { action: { character: 'B' }, label: { text: 'B' } },
        { action: { character: 'b' }, label: { text: 'b' } },
      ],
    },
    n: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``N' }, label: { text: 'Ń' } },
        { action: { sendKeys: '``n' }, label: { text: 'ń' } },
        { action: { character: 'N' }, label: { text: 'N' } },
        { action: { character: 'n' }, label: { text: 'n' } },
      ],
    },
    m: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``M' }, label: { text: 'Ḿ' } },
        { action: { sendKeys: '``m' }, label: { text: 'ḿ' } },
        { action: { character: 'M' }, label: { text: 'M' } },
        { action: { character: 'm' }, label: { text: 'm' } },
      ],
    },
  },
};

{
  alphabetic: transformKeyboard(baseData.alphabetic),
}
