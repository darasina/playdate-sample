-- メイン処理
-- Copyright © 2023 darasine
-- Released under the MIT license
-- https://opensource.org/licenses/mit-license.php

-- import "CoreLibs/object"
import "CoreLibs/graphics"
-- import "CoreLibs/sprites"
-- import "CoreLibs/timer"

-- グラフィクス処理クラスのエイリアス
local gfx <const> = playdate.graphics

-- サンプル音プレーヤー
local samplePlayer = nil
-- サンプル再生スピード
local rate = 1.0
-- クランク位置の変化量
local crank = 360

-- 初期処理を定義
function MyGameSetUp()
    -- つかわないupdateコールバックを無効化する
    playdate.stop()
    
    -- サンプル音を読み込んだプレイヤーを作成する
    samplePlayer = playdate.sound.sampleplayer.new("audio/otorii-kick.wav")
    assert(samplePlayer)     -- チェック
    gfx.drawRect(crank - 160, 0, 1,  200)   -- クランク位置表示の初期表示
end

-- 初期処理を実行
MyGameSetUp()

-- Bボタンおした
function playdate.BButtonDown()
    -- サンプル音を再生
    samplePlayer:play()
end

-- クランクうごかした
-- @param change うごかした量. 前回からの差分
-- @param acceleratedChange 速く動かしたとき変化量を増やしたやつ
function playdate.cranked(change, acceleratedChange)
    crank += change         -- 変化量を更新
    rate = crank / 360.0    -- 再生スピードを更新

    -- クランク変化量を線で表示
    gfx.clear()
    gfx.drawRect(crank - 160, 0, 1,  200)
end

-- Aボタンおした
function playdate.AButtonDown()
    -- 再生スピードを使って1回再生
    samplePlayer:play(1, rate)
end