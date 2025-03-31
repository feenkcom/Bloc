Class {
	#name : #BlWinit30KeyboardKeyTable,
	#superclass : #BlKeyboardKeyTable,
	#instVars : [
		'virtualKeyTable'
	],
	#classInstVars : [
		'default'
	],
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #cleanup }
BlWinit30KeyboardKeyTable class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.
	
	default := nil
]

{ #category : #cleanup }
BlWinit30KeyboardKeyTable class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #views }
BlWinit30KeyboardKeyTable >> gtVirtualKeyTableFor: aView [
	<gtView>
	^ aView forward
		title: 'Keys';
		priority: 5;
		object: [ virtualKeyTable ];
		view: #gtItemsFor:
]

{ #category : #initialization }
BlWinit30KeyboardKeyTable >> initialize [
	super initialize.

	self initializeVirtualKeyTable
]

{ #category : #initialization }
BlWinit30KeyboardKeyTable >> initializeVirtualKeyTable [
	self
		initialize: (virtualKeyTable := Dictionary new)
		withAssociations: ({
			"modifiers"
			(Winit30KeyboardKey leftKey: Winit30NamedKey ShiftKey) -> #ShiftLeft.
			(Winit30KeyboardKey rightKey: Winit30NamedKey ShiftKey) -> #ShiftRight.
			(Winit30KeyboardKey leftKey: Winit30NamedKey AltKey) -> #AltLeft.
			(Winit30KeyboardKey rightKey: Winit30NamedKey AltKey) -> #AltRight.
			(Winit30KeyboardKey leftKey: Winit30NamedKey ControlKey) -> #ControlLeft.
			(Winit30KeyboardKey rightKey: Winit30NamedKey ControlKey) -> #ControlRight.
			(Winit30KeyboardKey leftKey: Winit30NamedKey SuperKey) -> #MetaLeft.
			(Winit30KeyboardKey rightKey: Winit30NamedKey SuperKey) -> #MetaRight.
		
			"special"
			(Winit30KeyboardKey key: Winit30NamedKey EnterKey) -> #Return.
			(Winit30KeyboardKey key: Winit30NamedKey TabKey) -> #Tab.
			(Winit30KeyboardKey key: Winit30NamedKey SpaceKey) -> #Space.
			(Winit30KeyboardKey key: Winit30NamedKey DeleteKey) -> #Delete.
			(Winit30KeyboardKey key: Winit30NamedKey BackspaceKey) -> #Backspace.
			(Winit30KeyboardKey key: Winit30NamedKey EscapeKey) -> #Escape.
		
		},
	

			"sound"
			"VolumeUp VolumeUp
			VolumeDown VolumeDown
			Mute Mute
			PlayPause Pause" "!!"
			
		"functions"
		((1 to: 12) collect: [ :i |
			| keySelector namedKey |
			
			keySelector := ('F{1}Key' format: { i }) asSymbol.
			namedKey := Winit30NamedKey perform: keySelector.
		
			(Winit30KeyboardKey key: namedKey) -> ('F{1}' format: { i }) asSymbol ]),
		
		"navigation"
		{
			(Winit30KeyboardKey key: Winit30NamedKey ArrowLeftKey) -> #ArrowLeft.
			(Winit30KeyboardKey key: Winit30NamedKey ArrowRightKey) -> #ArrowRight.
			(Winit30KeyboardKey key: Winit30NamedKey ArrowDownKey) -> #ArrowDown.
			(Winit30KeyboardKey key: Winit30NamedKey ArrowUpKey) -> #ArrowUp.
			
			(Winit30KeyboardKey key: Winit30NamedKey HelpKey) -> #Help.
			(Winit30KeyboardKey key: Winit30NamedKey PrintScreenKey) -> #PrintScreen.
			(Winit30KeyboardKey key: Winit30NamedKey ScrollLockKey) -> #ScrollLock.
			(Winit30KeyboardKey key: Winit30NamedKey InsertKey) -> #Insert.
			(Winit30KeyboardKey key: Winit30NamedKey HomeKey) -> #Home.
			(Winit30KeyboardKey key: Winit30NamedKey PageUpKey) -> #PageUp.
			(Winit30KeyboardKey key: Winit30NamedKey PageDownKey) -> #PageDown.
			(Winit30KeyboardKey key: Winit30NamedKey EndKey) -> #End.
		},
		
		"letters"
		(($a to: $z) collect: [ :c | (Winit30KeyboardKey key: c asString) -> c asUppercase asSymbol ]),
		
		"digits"
		{
			(Winit30KeyboardKey key: '0') -> #Zero.
			(Winit30KeyboardKey key: '1') -> #One.
			(Winit30KeyboardKey key: '2') -> #Two.
			(Winit30KeyboardKey key: '3') -> #Three.
			(Winit30KeyboardKey key: '4') -> #Four.
			(Winit30KeyboardKey key: '5') -> #Five.
			(Winit30KeyboardKey key: '6') -> #Six.
			(Winit30KeyboardKey key: '7') -> #Seven.
			(Winit30KeyboardKey key: '8') -> #Eight.
			(Winit30KeyboardKey key: '9') -> #Nine.
		},
		
		"symbols"
		{
			(Winit30KeyboardKey key: '-') -> #Minus.
			(Winit30KeyboardKey key: '=') -> #Equal.
			(Winit30KeyboardKey key: '[') -> #LeftBracket.
			(Winit30KeyboardKey key: ']') -> #RightBracket.
			(Winit30KeyboardKey key: '''') -> #Quote.
			(Winit30KeyboardKey key: ';') -> #Semicolon.
			(Winit30KeyboardKey key: '/') -> #Slash.
			(Winit30KeyboardKey key: '\') -> #Backslash.
			(Winit30KeyboardKey key: '.') -> #Period.
			(Winit30KeyboardKey key: ',') -> #Comma.
			(Winit30KeyboardKey key: '`') -> #Grave.
		},
		
		{
			"symbols"
			"
			16r032 NonUsHash
			"
			
			"NumpadEnter NumpadEnter"
		})
]

{ #category : #initialization }
BlWinit30KeyboardKeyTable >> keyFromVirtualCode: aVirtualCode [
	<return: #BlKeyboardKey>

	^ virtualKeyTable
		at: aVirtualCode
		ifAbsent: [
			aVirtualCode location = Winit30KeyLocation StandardLocation
				ifTrue: [ BlKeyboardKey unknown: aVirtualCode ]
				ifFalse: [
					| standardKey |
					
					standardKey := Winit30KeyboardKey key: aVirtualCode key.
					self keyFromVirtualCode: standardKey ] ]
]
