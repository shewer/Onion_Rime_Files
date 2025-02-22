--- @@ array30_nil_filter
--[[
（onion-array30）
後來移至「=」「=」反查用。
行列30空碼'⎔'轉成不輸出任何符號，符合原生
--]]

-- -- preedit_format 格式轉寫（精簡不用）
-- local function xform_array30_input(ainput)
--   if ainput == "" then return "" end
--   ainput = string.gsub(ainput, "a", "1-")
--   ainput = string.gsub(ainput, "b", "5⇣")
--   ainput = string.gsub(ainput, "c", "3⇣")
--   ainput = string.gsub(ainput, "d", "3-")
--   ainput = string.gsub(ainput, "e", "3⇡")
--   ainput = string.gsub(ainput, "f", "4-")
--   ainput = string.gsub(ainput, "g", "5-")
--   ainput = string.gsub(ainput, "h", "6-")
--   ainput = string.gsub(ainput, "i", "8⇡")
--   ainput = string.gsub(ainput, "j", "7-")
--   ainput = string.gsub(ainput, "k", "8-")
--   ainput = string.gsub(ainput, "l", "9-")
--   ainput = string.gsub(ainput, "m", "7⇣")
--   ainput = string.gsub(ainput, "n", "6⇣")
--   ainput = string.gsub(ainput, "o", "9⇡")
--   ainput = string.gsub(ainput, "p", "0⇡")
--   ainput = string.gsub(ainput, "q", "1⇡")
--   ainput = string.gsub(ainput, "r", "4⇡")
--   ainput = string.gsub(ainput, "s", "2-")
--   ainput = string.gsub(ainput, "t", "5⇡")
--   ainput = string.gsub(ainput, "u", "7⇡")
--   ainput = string.gsub(ainput, "v", "4⇣")
--   ainput = string.gsub(ainput, "w", "2⇡")
--   ainput = string.gsub(ainput, "x", "2⇣")
--   ainput = string.gsub(ainput, "y", "6⇡")
--   ainput = string.gsub(ainput, "z", "1⇣")
--   ainput = string.gsub(ainput, "%.", "9⇣")
--   ainput = string.gsub(ainput, "/", "0⇣")
--   ainput = string.gsub(ainput, ";", "0-")
--   ainput = string.gsub(ainput, ",", "8⇣")
--   ainput = string.gsub(ainput, "% ", "▫")
--   ainput = string.gsub(ainput, "^==", "《查注音》")
--   return ainput
-- end

local function array30_nil_filter(input, env)
  local p_key = env.engine.context.input
  local array30_r = string.match(p_key, '^==')
  -- local array30_input = env.engine.context.input  -- 原始未轉換輸入碼
  if (array30_r) then
    for cand in input:iter() do
      if (string.match(cand.text, '^⎔%d$' )) then
        -- local cccc = string.gsub(cand.text, "^⎔2$", "⎔")
        -- cand.text = '⎔'
        -- cand:get_genuine().text = '@'
        -- cand:get_genuine().comment = cand.comment .. "⎔"
  --[[
        欲定義的 translator 包含三個輸入參數：
        - input: 待翻譯的字符串
        - seg: 包含 `start` 和 `_end` 兩個屬性，分別表示當前串在輸入框中的起始和結束位置
        - env: 可選參數，表示 translator 所處的環境
  --]]
        -- yield(Candidate("date", seg.start, seg._end, "⎔" , "〔日期〕"))
        -- yield(Candidate("date", seg.start, seg._end, string.gsub(cand.text, "^⎔2$", "⎔") , "〔日期〕"))
  --[[
        -- local commit = env.engine.context:get_commit_text()  -- 原版樣式
        -- local text = cand.text  -- 原版樣式
        -- yield(Candidate("cap", 0, string.len(commit) , text, cand.comment))  -- 原版樣式
  --]]
        local _end2 = env.engine.context:get_preedit().sel_end + 2
        -- local array30_nil_preedit = cand:get_genuine().preedit  -- 效用同下，獲取原 preedit
        local array30_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
        -- local array30_input = env.engine.context.input  -- 原始未轉換輸入碼
        local array30_nil_cand = Candidate("array30nil", 0, _end2, "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len('⎔')等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
        -- local array30_nil_cand = Candidate("array30nil", 0, string.len(array30_input) , "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len('⎔')等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
        -- local array30_nil_cand = Candidate("array30nil", 0, string.len(commit) , "", "⎔")  -- 選擇空碼"⎔"效果為卡住，但 preedit 顯示會有問題
        array30_nil_cand.preedit = array30_preedit
        -- array30_nil_cand.preedit = xform_array30_input(array30_input)  -- 使用 gsub 函數轉換，上列為不使用 gsub 轉換更精簡寫法
        yield(array30_nil_cand)
      else
        yield(cand)
      end
    end
    -- return nil
  else
    for cand in input:iter() do
      yield(cand)
    end
  end
end

return array30_nil_filter