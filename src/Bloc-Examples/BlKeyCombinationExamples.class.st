"
I contain examples of how to use key combination

"
Class {
	#name : #BlKeyCombinationExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'instance creation' }
BlKeyCombinationExamples >> arrowLeft [
	<gtExample>
	<return: #BlPhysicalKeyboardKey>
	^ BlKeyboardKey arrowLeft
]

{ #category : #accessing }
BlKeyCombinationExamples >> c [
	<gtExample>
	<return: #BlPhysicalKeyboardKey>
	^ BlKeyboardKey c
]

{ #category : #examples }
BlKeyCombinationExamples >> keyLogger [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 200 @ 200;
		background: Color red;
		beFocusable;
		addEventHandler: (BlEventHandler
				on: BlTextInputEvent
				do: [ :anEvent | self inform: 'Text input: ' , anEvent text ]);
		addEventHandler: (BlEventHandler
				on: BlKeyDownEvent
				do: [ :anEvent | self inform: 'Key down: ' , anEvent key asString ]);
		addShortcut: (BlShortcutWithAction new
				combination: (BlKeyCombination builder
						shift;
						meta;
						key: BlKeyboardKey arrowLeft;
						build);
				action: [ :anEvent :aShortcut | self inform: 'Triggered ' , aShortcut combination asString ]);
		addShortcut: (BlShortcutWithAction new
				combination: (BlSingleKeyCombination key: BlKeyboardKey a);
				action: [ self inform: 'Shortcut: a' ]);
		addShortcut: (BlShortcutWithAction new
				combination: (BlSingleKeyCombination key: BlKeyboardKey arrowUp);
				action: [ self inform: 'Shortcut: arrowUp' ]);
		addShortcut: (BlShortcutWithAction new
				combination: (BlKeyCombination builder
						meta;
						key: BlKeyboardKey arrowUp;
						build);
				action: [ self inform: 'Shortcut: meta + arrowUp' ]);
		addShortcut: (BlShortcutWithAction new
				combination: (BlKeyCombination builder
						shift;
						meta;
						key: BlKeyboardKey arrowUp;
						build);
				action: [ self inform: 'Shortcut: meta + shift + arrowUp' ]);
		requestFocus;
		yourself
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> leftMeta [
	<gtExample>
	<return: #BlPhysicalKeyboardKey>
	^ BlKeyboardKey metaLeft
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> leftShift [
	<gtExample>
	<return: #BlPhysicalKeyboardKey>
	^ BlKeyboardKey shiftLeft
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> rightMeta [
	<gtExample>
	<return: #BlPhysicalKeyboardKey>
	^ BlKeyboardKey metaRight
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> rightShift [
	<gtExample>
	<return: #BlPhysicalKeyboardKey>
	^ BlKeyboardKey shiftLeft
]
