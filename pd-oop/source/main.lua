-- メイン処理

-- Copyright © 2023 darasine
-- Released under the MIT license
-- https://opensource.org/licenses/mit-license.php

import "CoreLibs/object"
-- import "CoreLibs/graphics"
-- import "CoreLibs/sprites"
-- import "CoreLibs/timer"

-- クラス定義ファイルをインポート。拡張子は要らないみたい
import "levelmeter"

local gfx <const> = playdate.graphics
local levelMeter = nil                  -- レベルメーターオブジェクト変数
local changeMeter = nil

--- 初期処理定義
function MyGameSetUp()
    -- レベルメーターオブジェクトを生成
    -- 同じクラスのパラメータ違いで実装してみる
    -- クランクの現在位置を表示するメーター
    levelMeter = LevelMeter(playdate.geometry.rect.new(0, 0, 32, 240), 360, 0, 0)
    -- クランクの変化量を表示するメーター
    changeMeter = LevelMeter(playdate.geometry.rect.new(32, 20, 32, 200), 100, -100, 0)
end

MyGameSetUp()   -- 初期処理呼び出し

-- フレーム処理(デフォルト=30fps)
function playdate.update()
    -- クランクが格納されていないか
    if not playdate.isCrankDocked() then
        -- 格納されていないなら、位置を取得
        levelMeter:setLevel(playdate.getCrankPosition())    -- メソッドでレベル設定
        changeMeter.level = playdate.getCrankChange()       -- メンバを更新してレベル設定
    else
        -- 格納されているなら、0
        levelMeter.level = 0
        changeMeter.level = 0
    end

    -- レベルメーターを描画
    levelMeter:draw()
    changeMeter:draw()
    -- * 毎フレーム描画するのはムダだけど気にしない

    -- gfx.sprite.update()
    -- playdate.timer.updateTimers()
end