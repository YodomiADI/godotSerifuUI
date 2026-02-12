#DialogueSystem.gd
extends Control

# @onreadyをつけて、ノードを正しく捕まえます
@onready var name_label = $MainFrame/HBox/TextContainer/NameLabel
@onready var text_label = $MainFrame/HBox/TextContainer/DialogueLabel
@onready var portrait_rect = $MainFrame/HBox/PortraitContainer/FaceImage


func _ready():
	# アニメーションプレイヤーのノードを取得して再生
	# (名前は実際のノード名に合わせてください。$AnimationPlayer等)
	$AnimationPlayer.play("play_dialogue")

func play_dialogue(entry: DialogueEntry):
	if not entry:
		print("エラー: データが空です") # デバッグ用に追加
		return
	
	# データをセット
	name_label.text = entry.character_name
	text_label.text = entry.text
	portrait_rect.texture = entry.portrait
	
	# --- エフェクトの制御を追加 ---
	# まずは音符パーティクルを止める
	var note_particles = $MainFrame/HBox/PortraitContainer/NoteParticles
	# 一旦、非表示にして放出を止める
	
	note_particles.emitting = false
	note_particles.visible = false 
	note_particles.restart() # 前の残骸を消す
	
	# セリフデータの設定に応じてエフェクトを起動
	match entry.effect:
		DialogueEntry.EffectType.NOTES:
			# 音符エフェクトの時だけ「見えるようにして」「放出」する
			note_particles.visible = true
			note_particles.emitting = true
			
		DialogueEntry.EffectType.LAUGH:
			# ケラケラ笑う（画像を揺らす）演出
			play_laugh_animation()
		DialogueEntry.EffectType.NONE:
			# 何もしない（既にリセット済みなので消えたままになる）
			pass
		
	# --- Tweenの設定 ---
	text_label.visible_ratio = 0.0  # 最初は文字を隠す
	var tween = create_tween()
	
	# 1秒かけて visible_ratio を 0 から 1 にする（文字数に応じて時間は調整可能）
	tween.tween_property(text_label, "visible_ratio", 1.0, 1.0)
	
	# 念のため、1.0（全表示）を強制する行は消すかコメントアウト
	# text_label.visible_ratio = 1.0

# おまけ：笑う時のひょこひょこアニメーション
func play_laugh_animation():
	var tw = create_tween()
	# 上下に3回ひょこひょこ動かす
	for i in range(3):
		tw.tween_property(portrait_rect, "position:y", -10, 0.1).as_relative()
		tw.tween_property(portrait_rect, "position:y", 10, 0.1).as_relative()
