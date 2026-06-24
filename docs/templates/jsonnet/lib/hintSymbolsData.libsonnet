// 長按符號數據 - 蝦米專用
// 左半邊（Q~T, A~G, Z~V）：[小寫symbol, 大寫symbol, 小寫變化形, 大寫變化形]，selectedIndex: 0
// 右半邊（Y~P, H~L, B~M）：[大寫變化形, 小寫變化形, 大寫symbol, 小寫symbol]，selectedIndex: 3
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
  pinyin: {
    // 第一排 Q~P
    q: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'q' }, label: { text: 'q' } },
        { action: { symbol: 'Q' }, label: { text: 'Q' } },
        { action: { sendKeys: '``q' }, label: { text: 'ɋ' } },
        { action: { sendKeys: '``Q' }, label: { text: 'Ɋ' } },
      ],
    },
    w: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'w' }, label: { text: 'w' } },
        { action: { symbol: 'W' }, label: { text: 'W' } },
        { action: { sendKeys: '``w' }, label: { text: 'ẁ' } },
        { action: { sendKeys: '``W' }, label: { text: 'Ẁ' } },
      ],
    },
    e: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'e' }, label: { text: 'e' } },
        { action: { symbol: 'E' }, label: { text: 'E' } },
        { action: { sendKeys: '``e' }, label: { text: 'ē' } },
        { action: { sendKeys: '``E' }, label: { text: 'Ē' } },
      ],
    },
    r: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'r' }, label: { text: 'r' } },
        { action: { symbol: 'R' }, label: { text: 'R' } },
        { action: { sendKeys: '``r' }, label: { text: 'ŕ' } },
        { action: { sendKeys: '``R' }, label: { text: 'Ŕ' } },
      ],
    },
    t: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 't' }, label: { text: 't' } },
        { action: { symbol: 'T' }, label: { text: 'T' } },
        { action: { sendKeys: '``t' }, label: { text: 'ṫ' } },
        { action: { sendKeys: '``T' }, label: { text: 'Ṫ' } },
      ],
    },
    y: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``Y' }, label: { text: 'Ȳ' } },
        { action: { sendKeys: '``y' }, label: { text: 'ȳ' } },
        { action: { symbol: 'Y' }, label: { text: 'Y' } },
        { action: { symbol: 'y' }, label: { text: 'y' } },
      ],
    },
    u: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``U' }, label: { text: 'Ū' } },
        { action: { sendKeys: '``u' }, label: { text: 'ū' } },
        { action: { symbol: 'U' }, label: { text: 'U' } },
        { action: { symbol: 'u' }, label: { text: 'u' } },
      ],
    },
    i: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``I' }, label: { text: 'Ī' } },
        { action: { sendKeys: '``i' }, label: { text: 'ī' } },
        { action: { symbol: 'I' }, label: { text: 'I' } },
        { action: { symbol: 'i' }, label: { text: 'i' } },
      ],
    },
    o: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``O' }, label: { text: 'Ō' } },
        { action: { sendKeys: '``o' }, label: { text: 'ō' } },
        { action: { symbol: 'O' }, label: { text: 'O' } },
        { action: { symbol: 'o' }, label: { text: 'o' } },
      ],
    },
    p: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``P' }, label: { text: 'Ṕ' } },
        { action: { sendKeys: '``p' }, label: { text: 'ṕ' } },
        { action: { symbol: 'P' }, label: { text: 'P' } },
        { action: { symbol: 'p' }, label: { text: 'p' } },
      ],
    },

    // 第二排 A~L
    a: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'a' }, label: { text: 'a' } },
        { action: { symbol: 'A' }, label: { text: 'A' } },
        { action: { sendKeys: '``a' }, label: { text: 'ā' } },
        { action: { sendKeys: '``A' }, label: { text: 'Ā' } },
      ],
    },
    s: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 's' }, label: { text: 's' } },
        { action: { symbol: 'S' }, label: { text: 'S' } },
        { action: { sendKeys: '``s' }, label: { text: 'ś' } },
        { action: { sendKeys: '``S' }, label: { text: 'Ś' } },
      ],
    },
    d: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'd' }, label: { text: 'd' } },
        { action: { symbol: 'D' }, label: { text: 'D' } },
        { action: { sendKeys: '``d' }, label: { text: 'ḋ' } },
        { action: { sendKeys: '``D' }, label: { text: 'Ḋ' } },
        { action: { sendKeys: 'Control+equal' }, label: { text: '計算' }, fontSize: 14 },
      ],
    },
    f: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'f' }, label: { text: 'f' } },
        { action: { symbol: 'F' }, label: { text: 'F' } },
        { action: { sendKeys: '``f' }, label: { text: 'ḟ' } },
        { action: { sendKeys: '``F' }, label: { text: 'Ḟ' } },
      ],
    },
    g: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'g' }, label: { text: 'g' } },
        { action: { symbol: 'G' }, label: { text: 'G' } },
        { action: { sendKeys: '``g' }, label: { text: 'ḡ' } },
        { action: { sendKeys: '``G' }, label: { text: 'Ḡ' } },
      ],
    },
    h: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``H' }, label: { text: 'Ḣ' } },
        { action: { sendKeys: '``h' }, label: { text: 'ḣ' } },
        { action: { symbol: 'H' }, label: { text: 'H' } },
        { action: { symbol: 'h' }, label: { text: 'h' } },
      ],
    },
    j: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``J' }, label: { text: 'Ĵ' } },
        { action: { sendKeys: '``j' }, label: { text: 'ĵ' } },
        { action: { symbol: 'J' }, label: { text: 'J' } },
        { action: { symbol: 'j' }, label: { text: 'j' } },
      ],
    },
    k: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``K' }, label: { text: 'Ḱ' } },
        { action: { sendKeys: '``k' }, label: { text: 'ḱ' } },
        { action: { symbol: 'K' }, label: { text: 'K' } },
        { action: { symbol: 'k' }, label: { text: 'k' } },
      ],
    },
    l: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``L' }, label: { text: 'Ĺ' } },
        { action: { sendKeys: '``l' }, label: { text: 'ĺ' } },
        { action: { symbol: 'L' }, label: { text: 'L' } },
        { action: { symbol: 'l' }, label: { text: 'l' } },
      ],
    },

    // 第三排 Z~M
    z: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'z' }, label: { text: 'z' } },
        { action: { symbol: 'Z' }, label: { text: 'Z' } },
        { action: { sendKeys: '``z' }, label: { text: 'ź' } },
        { action: { sendKeys: '``Z' }, label: { text: 'Ź' } },
      ],
    },
    x: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'x' }, label: { text: 'x' } },
        { action: { symbol: 'X' }, label: { text: 'X' } },
        { action: { sendKeys: '``x' }, label: { text: 'ẋ' } },
        { action: { sendKeys: '``X' }, label: { text: 'Ẋ' } },
      ],
    },
    c: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'c' }, label: { text: 'c' } },
        { action: { symbol: 'C' }, label: { text: 'C' } },
        { action: { sendKeys: '``c' }, label: { text: 'ć' } },
        { action: { sendKeys: '``C' }, label: { text: 'Ć' } },
      ],
    },
    v: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'v' }, label: { text: 'v' } },
        { action: { symbol: 'V' }, label: { text: 'V' } },
        { action: { sendKeys: '``v' }, label: { text: 'ṽ' } },
        { action: { sendKeys: '``V' }, label: { text: 'Ṽ' } },
      ],
    },
    b: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``B' }, label: { text: 'Ḃ' } },
        { action: { sendKeys: '``b' }, label: { text: 'ḃ' } },
        { action: { symbol: 'B' }, label: { text: 'B' } },
        { action: { symbol: 'b' }, label: { text: 'b' } },
      ],
    },
    n: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``N' }, label: { text: 'Ń' } },
        { action: { sendKeys: '``n' }, label: { text: 'ń' } },
        { action: { symbol: 'N' }, label: { text: 'N' } },
        { action: { symbol: 'n' }, label: { text: 'n' } },
      ],
    },
    m: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``M' }, label: { text: 'Ḿ' } },
        { action: { sendKeys: '``m' }, label: { text: 'ḿ' } },
        { action: { symbol: 'M' }, label: { text: 'M' } },
        { action: { symbol: 'm' }, label: { text: 'm' } },
      ],
    },
    // 逗號鍵長按：時間、日期、中文、民國、日本
    comma: {
      selectedIndex: 0,
      size: { width: 40, height: 53 },
      list: [
        { action: { sendKeys: '``/01' }, label: { text: '時間' }, fontSize: 14 },
        { action: { sendKeys: '``/02' }, label: { text: '日期' }, fontSize: 14 },
        { action: { sendKeys: '``/03' }, label: { text: '中文' }, fontSize: 14 },
        { action: { sendKeys: '``/04' }, label: { text: '民國' }, fontSize: 14 },
        { action: { sendKeys: '``/05' }, label: { text: '日本' }, fontSize: 14 },
      ],
    },
    // 句號鍵長按：英文、農曆、組合、時區、節氣
    period: {
      selectedIndex: 4,
      size: { width: 40, height: 53 },
      list: [
        { action: { sendKeys: '``/06' }, label: { text: '英文' }, fontSize: 14 },
        { action: { sendKeys: '``/07' }, label: { text: '農曆' }, fontSize: 14 },
        { action: { sendKeys: '``/08' }, label: { text: '組合' }, fontSize: 14 },
        { action: { sendKeys: '``/09' }, label: { text: '時區' }, fontSize: 14 },
        { action: { sendKeys: '``/10' }, label: { text: '節氣' }, fontSize: 14 },
      ],
    },
  },


  // 英文鍵盤版本 - 同步更新
  alphabetic: {
    // 第一排 Q~P
    q: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'q' }, label: { text: 'q' } },
        { action: { symbol: 'Q' }, label: { text: 'Q' } },
        { action: { sendKeys: '``q' }, label: { text: 'ɋ' } },
        { action: { sendKeys: '``Q' }, label: { text: 'Ɋ' } },
      ],
    },
    w: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'w' }, label: { text: 'w' } },
        { action: { symbol: 'W' }, label: { text: 'W' } },
        { action: { sendKeys: '``w' }, label: { text: 'ẁ' } },
        { action: { sendKeys: '``W' }, label: { text: 'Ẁ' } },
      ],
    },
    e: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'e' }, label: { text: 'e' } },
        { action: { symbol: 'E' }, label: { text: 'E' } },
        { action: { sendKeys: '``e' }, label: { text: 'ē' } },
        { action: { sendKeys: '``E' }, label: { text: 'Ē' } },
      ],
    },
    r: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'r' }, label: { text: 'r' } },
        { action: { symbol: 'R' }, label: { text: 'R' } },
        { action: { sendKeys: '``r' }, label: { text: 'ŕ' } },
        { action: { sendKeys: '``R' }, label: { text: 'Ŕ' } },
      ],
    },
    t: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 't' }, label: { text: 't' } },
        { action: { symbol: 'T' }, label: { text: 'T' } },
        { action: { sendKeys: '``t' }, label: { text: 'ṫ' } },
        { action: { sendKeys: '``T' }, label: { text: 'Ṫ' } },
      ],
    },
    y: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``Y' }, label: { text: 'Ȳ' } },
        { action: { sendKeys: '``y' }, label: { text: 'ȳ' } },
        { action: { symbol: 'Y' }, label: { text: 'Y' } },
        { action: { symbol: 'y' }, label: { text: 'y' } },
      ],
    },
    u: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``U' }, label: { text: 'Ū' } },
        { action: { sendKeys: '``u' }, label: { text: 'ū' } },
        { action: { symbol: 'U' }, label: { text: 'U' } },
        { action: { symbol: 'u' }, label: { text: 'u' } },
      ],
    },
    i: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``I' }, label: { text: 'Ī' } },
        { action: { sendKeys: '``i' }, label: { text: 'ī' } },
        { action: { symbol: 'I' }, label: { text: 'I' } },
        { action: { symbol: 'i' }, label: { text: 'i' } },
      ],
    },
    o: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``O' }, label: { text: 'Ō' } },
        { action: { sendKeys: '``o' }, label: { text: 'ō' } },
        { action: { symbol: 'O' }, label: { text: 'O' } },
        { action: { symbol: 'o' }, label: { text: 'o' } },
      ],
    },
    p: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``P' }, label: { text: 'Ṕ' } },
        { action: { sendKeys: '``p' }, label: { text: 'ṕ' } },
        { action: { symbol: 'P' }, label: { text: 'P' } },
        { action: { symbol: 'p' }, label: { text: 'p' } },
      ],
    },

    // 第二排 A~L
    a: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'a' }, label: { text: 'a' } },
        { action: { symbol: 'A' }, label: { text: 'A' } },
        { action: { sendKeys: '``a' }, label: { text: 'ā' } },
        { action: { sendKeys: '``A' }, label: { text: 'Ā' } },
      ],
    },
    s: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 's' }, label: { text: 's' } },
        { action: { symbol: 'S' }, label: { text: 'S' } },
        { action: { sendKeys: '``s' }, label: { text: 'ś' } },
        { action: { sendKeys: '``S' }, label: { text: 'Ś' } },
      ],
    },
    d: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'd' }, label: { text: 'd' } },
        { action: { symbol: 'D' }, label: { text: 'D' } },
        { action: { sendKeys: '``d' }, label: { text: 'ḋ' } },
        { action: { sendKeys: '``D' }, label: { text: 'Ḋ' } },
        { action: { sendKeys: 'Control+equal' }, label: { text: '計算' }, fontSize: 14 },
      ],
    },
    f: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'f' }, label: { text: 'f' } },
        { action: { symbol: 'F' }, label: { text: 'F' } },
        { action: { sendKeys: '``f' }, label: { text: 'ḟ' } },
        { action: { sendKeys: '``F' }, label: { text: 'Ḟ' } },
      ],
    },
    g: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'g' }, label: { text: 'g' } },
        { action: { symbol: 'G' }, label: { text: 'G' } },
        { action: { sendKeys: '``g' }, label: { text: 'ḡ' } },
        { action: { sendKeys: '``G' }, label: { text: 'Ḡ' } },
      ],
    },
    h: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``H' }, label: { text: 'Ḣ' } },
        { action: { sendKeys: '``h' }, label: { text: 'ḣ' } },
        { action: { symbol: 'H' }, label: { text: 'H' } },
        { action: { symbol: 'h' }, label: { text: 'h' } },
      ],
    },
    j: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``J' }, label: { text: 'Ĵ' } },
        { action: { sendKeys: '``j' }, label: { text: 'ĵ' } },
        { action: { symbol: 'J' }, label: { text: 'J' } },
        { action: { symbol: 'j' }, label: { text: 'j' } },
      ],
    },
    k: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``K' }, label: { text: 'Ḱ' } },
        { action: { sendKeys: '``k' }, label: { text: 'ḱ' } },
        { action: { symbol: 'K' }, label: { text: 'K' } },
        { action: { symbol: 'k' }, label: { text: 'k' } },
      ],
    },
    l: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``L' }, label: { text: 'Ĺ' } },
        { action: { sendKeys: '``l' }, label: { text: 'ĺ' } },
        { action: { symbol: 'L' }, label: { text: 'L' } },
        { action: { symbol: 'l' }, label: { text: 'l' } },
      ],
    },

    // 第三排 Z~M
    z: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'z' }, label: { text: 'z' } },
        { action: { symbol: 'Z' }, label: { text: 'Z' } },
        { action: { sendKeys: '``z' }, label: { text: 'ź' } },
        { action: { sendKeys: '``Z' }, label: { text: 'Ź' } },
      ],
    },
    x: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'x' }, label: { text: 'x' } },
        { action: { symbol: 'X' }, label: { text: 'X' } },
        { action: { sendKeys: '``x' }, label: { text: 'ẋ' } },
        { action: { sendKeys: '``X' }, label: { text: 'Ẋ' } },
      ],
    },
    c: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'c' }, label: { text: 'c' } },
        { action: { symbol: 'C' }, label: { text: 'C' } },
        { action: { sendKeys: '``c' }, label: { text: 'ć' } },
        { action: { sendKeys: '``C' }, label: { text: 'Ć' } },
      ],
    },
    v: {
      selectedIndex: 0,
      list: [
        { action: { symbol: 'v' }, label: { text: 'v' } },
        { action: { symbol: 'V' }, label: { text: 'V' } },
        { action: { sendKeys: '``v' }, label: { text: 'ṽ' } },
        { action: { sendKeys: '``V' }, label: { text: 'Ṽ' } },
      ],
    },
    b: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``B' }, label: { text: 'Ḃ' } },
        { action: { sendKeys: '``b' }, label: { text: 'ḃ' } },
        { action: { symbol: 'B' }, label: { text: 'B' } },
        { action: { symbol: 'b' }, label: { text: 'b' } },
      ],
    },
    n: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``N' }, label: { text: 'Ń' } },
        { action: { sendKeys: '``n' }, label: { text: 'ń' } },
        { action: { symbol: 'N' }, label: { text: 'N' } },
        { action: { symbol: 'n' }, label: { text: 'n' } },
      ],
    },
    m: {
      selectedIndex: 3,
      list: [
        { action: { sendKeys: '``M' }, label: { text: 'Ḿ' } },
        { action: { sendKeys: '``m' }, label: { text: 'ḿ' } },
        { action: { symbol: 'M' }, label: { text: 'M' } },
        { action: { symbol: 'm' }, label: { text: 'm' } },
      ],
    },
    // 逗號鍵長按：時間、日期、中文、民國、日本
    comma: {
      selectedIndex: 0,
      size: { width: 40, height: 53 },
      list: [
        { action: { sendKeys: '``/01' }, label: { text: '時間' }, fontSize: 14 },
        { action: { sendKeys: '``/02' }, label: { text: '日期' }, fontSize: 14 },
        { action: { sendKeys: '``/03' }, label: { text: '中文' }, fontSize: 14 },
        { action: { sendKeys: '``/04' }, label: { text: '民國' }, fontSize: 14 },
        { action: { sendKeys: '``/05' }, label: { text: '日本' }, fontSize: 14 },
      ],
    },
    // 句號鍵長按：英文、農曆、組合、時區、節氣
    period: {
      selectedIndex: 4,
      size: { width: 40, height: 53 },
      list: [
        { action: { sendKeys: '``/06' }, label: { text: '英文' }, fontSize: 14 },
        { action: { sendKeys: '``/07' }, label: { text: '農曆' }, fontSize: 14 },
        { action: { sendKeys: '``/08' }, label: { text: '組合' }, fontSize: 14 },
        { action: { sendKeys: '``/09' }, label: { text: '時區' }, fontSize: 14 },
        { action: { sendKeys: '``/10' }, label: { text: '節氣' }, fontSize: 14 },
      ],
    },
  },
};

{
  pinyin: transformKeyboard(baseData.pinyin),
  alphabetic: transformKeyboard(baseData.alphabetic),
}
