# DialogueEntry.gd
extends Resource
class_name DialogueEntry

# エフェクトの種類を定義
enum EffectType { NONE, NOTES, LAUGH }

@export var character_name: String = ""
@export var portrait: Texture2D
@export_multiline var text: String = ""
@export var effect: EffectType = EffectType.NONE # インスペクターで選べるようになります
