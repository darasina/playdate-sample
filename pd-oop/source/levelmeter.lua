-- レベルメーター描画クラス
--
-- Copyright © 2023 darasine
-- Released under the MIT license
-- https://opensource.org/licenses/mit-license.php

-- 定数
local STYLE_VERTICAL <const> = 1
-- * クラス定数、メンバ定数の定義方法はわからない。。。

local gfx <const> = playdate.graphics

-- クラス宣言
-- [properties]でプロパティの初期化ができる。複雑な初期化は難しいから、コンストラクタでやった方がよさそう
class('LevelMeter', {style = STYLE_VERTICAL}).extends()
-- * styleはプロパティ初期化の例で書いただけで、機能上では未使用。

-- コンストラクタ
function LevelMeter:init(rect, maxLevel, minLevel, initLevel)
    -- プロパティの初期化はここでもOK
    -- 両方つかうとここが後に実行されて、こちらの値になる
    self.rect = rect                                    -- 描画範囲
    self.minLevel = minLevel                            -- メーター最小値
    self.maxLevel = maxLevel                            -- メーター最大値
    self.level = initLevel                              -- メーター初期値
    self.level_width = self.maxLevel - self.minLevel    -- メーター値の幅 ex. -200 <-> 200なら400
end

-- レベルメーターの描画範囲を設定する
function LevelMeter:setRect(rect)
    self.rect = rect
end

-- 描画処理
function LevelMeter:draw()
    -- 高レベルを-y、低レベルを+yで描画する
    gfx.pushContext()
    local r = self.rect
    local level_h = r.h * (self.level / self.level_width)
    local origin_h = r.h * (self.maxLevel / self.level_width)
    -- レベル外は白
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(self.rect)
    -- レベルを黒で描画
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(r.x, r.y + origin_h, r.w, -level_h)
    gfx.popContext()
end

-- レベル設定メソッド
-- メンバが公開されるので特別な処理が要らなければアクセッサは定義不要みたい
function LevelMeter:setLevel(level)
    -- 適正値かチェックしたり、修正したりしてもよいし、しなくてもよい
    if level then
        self.level = level
    else
        self.level = 0
    end
end