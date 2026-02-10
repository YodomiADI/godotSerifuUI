#DialogueEntry.gd
extends Resource
class_name DialogueEntry

@export var character_name: String = "名前"
@export var portrait: Texture2D            # ここに1:1の顔画像をドロップ
@export_multiline var text: String = ""    # セリフ本文
