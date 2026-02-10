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
	
	# --- Tweenの設定 ---
	text_label.visible_ratio = 0.0  # 最初は文字を隠す
	var tween = create_tween()
	
	# 1秒かけて visible_ratio を 0 から 1 にする（文字数に応じて時間は調整可能）
	tween.tween_property(text_label, "visible_ratio", 1.0, 1.0)
	
	# 念のため、1.0（全表示）を強制する行は消すかコメントアウト
	# text_label.visible_ratio = 1.0
