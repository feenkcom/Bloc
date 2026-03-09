"
I exemplify {{gtClass:BlShortcutForwardingHandler}}.  
"
Class {
	#name : #BlShortcutForwardingHandlerExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Event'
}

{ #category : #asserting }
BlShortcutForwardingHandlerExamples >> assert: scripter id: anElementId index: anInteger [
	| query |
	query := scripter element query // anElementId.

	self
		assert: query all size = 1
		description: [ 'There must be just one element {1}, found {2} instead'
				format: {anElementId.
						query all size} ].

	query anyOne
		childWithId: #index
		ifFound: [ :aLabel | self assert: aLabel text asString asInteger equals: anInteger ]
		ifNone: [ AssertionFailure
				signal: ('Element must have #index child: {1}' format: query anyOne) ]
]

{ #category : #support }
BlShortcutForwardingHandlerExamples >> disableIncreaseShortcut: scripter [
	scripter shortcut
		combination: (BlKeyCombination builder
				key: BlKeyboardKey d;
				build);
		// #one;
		play
]

{ #category : #examples }
BlShortcutForwardingHandlerExamples >> elementWithIndex [
	<gtExample>
	| elementOne |
	elementOne := BlElement new
			layout: BlLinearLayout horizontal alignCenter;
			constraintsDo: [ :c | 
				c horizontal exact: 100.
				c vertical exact: 100 ];
			background: (Color orange alpha: 0.3);
			addChild: (BlTextElement new text: '1' asRopedText) as: #index.

	^ elementOne
]

{ #category : #support }
BlShortcutForwardingHandlerExamples >> enableIncreaseShortcut: scripter [
	scripter shortcut
		combination: (BlKeyCombination builder
				key: BlKeyboardKey e;
				build);
		// #one;
		play
]

{ #category : #support }
BlShortcutForwardingHandlerExamples >> hideShortcut: scripter [
	scripter shortcut
		combination: (BlKeyCombination builder
				key: BlKeyboardKey h;
				build);
		// #one;
		play
]

{ #category : #support }
BlShortcutForwardingHandlerExamples >> increaseShortcut: scripter [
	scripter shortcut
		combination: (BlKeyCombination builder
				key: BlKeyboardKey c;
				build);
		// #one;
		play
]

{ #category : #support }
BlShortcutForwardingHandlerExamples >> onIncreaseEvent: aShortcutEvent [
	aShortcutEvent currentTarget
		childWithId: #index
		ifFound: [ :aLabel | 
			aLabel text: (aLabel text asString asInteger + 1) asString asRopedText.
			aShortcutEvent consumed: true ]
		ifNone: [  ]
]

{ #category : #examples }
BlShortcutForwardingHandlerExamples >> sceneOne [
	<gtExample>
	| elementOne elementTwo container footer |
	elementOne := self elementWithIndex
			id: #one;
			background: (Color red alpha: 0.5);
			when: BlClickEvent
				do: [ :anEvent | (anEvent currentTarget childWithId: #index) requestFocus ];
			addShortcut: (BlShortcutWithAction new
					name: 'Change color';
					combination: (BlKeyCombination builder
							key: BlKeyboardKey c;
							build);
					action: [ :aShortcutEvent :aShortcut | 
						self assert: aShortcutEvent currentTarget equals: elementOne.
						self onIncreaseEvent: aShortcutEvent ]);
			addShortcut: (BlShortcutWithAction new
					name: 'Show the second element';
					combination: (BlKeyCombination builder
							key: BlKeyboardKey s;
							build);
					action: [ :aShortcutEvent :aShortcut | 
						self assert: aShortcutEvent currentTarget equals: elementOne.
						elementTwo hasParent
							ifFalse: [ aShortcutEvent currentTarget parent addChild: elementTwo ] ]);
			addShortcut: (BlShortcutWithAction new
					name: 'Enable forwarding shortcuts';
					combination: (BlKeyCombination builder
							key: BlKeyboardKey e;
							build);
					action: [ :aShortcutEvent :aShortcut | 
						self assert: aShortcutEvent currentTarget equals: elementOne.
						aShortcutEvent currentTarget eventDispatcher forwardShortcuts
							targetObject: container;
							// #two ]);
			addShortcut: (BlShortcutWithAction new
					name: 'Disable forwarding shortcuts';
					combination: (BlKeyCombination builder
							key: BlKeyboardKey d;
							build);
					action: [ :aShortcutEvent :aShortcut | 
						self assert: aShortcutEvent currentTarget equals: elementOne.
						aShortcutEvent currentTarget eventDispatcher noForwardShortcuts ]).

	footer := BlTextElement new text: 'Footer: ' asRopedText;
	padding: (BlInsets left: 10 right: 10).

	elementTwo := self elementWithIndex
			constraintsDo: [ :c | 
				c horizontal exact: 200.
				c vertical exact: 100 ];
			id: #two;
			background: (Color blue alpha: 0.5);
			addShortcut: (BlShortcutWithAction new
					name: 'Change color';
					combination: (BlKeyCombination builder
							key: BlKeyboardKey c;
							build);
					action: [ :aShortcutEvent :aShortcut | 
						self assert: aShortcutEvent currentTarget equals: elementTwo.
						self onIncreaseEvent: aShortcutEvent ]);
			addShortcut: (BlShortcutWithAction new
					name: 'Hide the second element';
					combination: (BlKeyCombination builder
							key: BlKeyboardKey h;
							build);
					action: [ :aShortcutEvent :aShortcut | 
						self assert: aShortcutEvent currentTarget equals: elementTwo.
						aShortcutEvent currentTarget removeFromParent ]);
			addShortcut: (BlShortcutWithAction new
					overrideChildren: true;
					name: 'Add blue into a container footer';
					combination: (BlKeyCombination builder
							key: BlKeyboardKey x;
							build);
					action: [ :aShortcutEvent :aShortcut | 
						self assert: aShortcutEvent currentTarget equals: elementTwo.
						footer text: (footer text asString , ' blue') asRopedText ]).

	container := BlElement new
			layout: (BlLinearLayout horizontal cellSpacing: 10);
			constraintsDo: [ :c | 
				c padding: (BlInsets top: 10 bottom: 10).
				c horizontal fitContent.
				c vertical fitContent ];
			addChild: elementOne.

	(elementOne childWithId: #index)
		beFocusable;
		requestFocus;
		addShortcut: (BlShortcutWithAction new
				name: 'Add red into a container footer';
				combination: (BlKeyCombination builder
						key: BlKeyboardKey x;
						build);
				action: [ :aShortcutEvent :aShortcut | 
					self
						assert: aShortcutEvent currentTarget
						equals: (elementOne childWithId: #index).
					footer text: (footer text asString , ' red') asRopedText ]).

	elementOne eventDispatcher forwardShortcuts
		targetObject: container;
		// #two.

	^ BlElement new
		layout: (BlLinearLayout vertical cellSpacing: 10);
		constraintsDo: [ :c | 
			c padding: (BlInsets left: 10 right: 10).
			c horizontal fitContent.
			c vertical fitContent ];
		addChild: container;
		addChild: footer
]

{ #category : #examples }
BlShortcutForwardingHandlerExamples >> scripterOne [
	<gtExample>
	| container scripter |
	container := self sceneOne.
	scripter := BlScripter new element: container.
	
	self assert: scripter id: #one index: 1.
	
	^ scripter
]

{ #category : #examples }
BlShortcutForwardingHandlerExamples >> scripterOne_increaseOne [
	<gtExample>
	| scripter |
	scripter := self scripterOne.

	self increaseShortcut: scripter.
	self assert: scripter id: #one index: 2.
	
	^ scripter
]

{ #category : #examples }
BlShortcutForwardingHandlerExamples >> scripterOne_increaseOne_showTwo [
	<gtExample>
	| scripter |
	scripter := self scripterOne_increaseOne.

	self showShortcut: scripter.
	self assert: scripter id: #one index: 2.
	self assert: scripter id: #two index: 1.
	
	^ scripter
]

{ #category : #examples }
BlShortcutForwardingHandlerExamples >> scripterOne_increaseOne_showTwo_increaseTwo [
	<gtExample>
	| scripter |
	scripter := self scripterOne_increaseOne_showTwo.

	self increaseShortcut: scripter.
	self assert: scripter id: #one index: 2.
	self assert: scripter id: #two index: 2.
	
	^ scripter
]

{ #category : #examples }
BlShortcutForwardingHandlerExamples >> scripterOne_increaseOne_showTwo_increaseTwo_disableIncrease [
	<gtExample>
	| scripter |
	scripter := self scripterOne_increaseOne_showTwo_increaseTwo.

	self disableIncreaseShortcut: scripter.
	self increaseShortcut: scripter.
	
	self assert: scripter id: #one index: 3.
	self assert: scripter id: #two index: 2.
	
	^ scripter
]

{ #category : #examples }
BlShortcutForwardingHandlerExamples >> scripterOne_increaseOne_showTwo_increaseTwo_disableIncrease_enableIncrease [
	<gtExample>
	| scripter |
	scripter := self scripterOne_increaseOne_showTwo_increaseTwo_disableIncrease.

	self enableIncreaseShortcut: scripter.
	self increaseShortcut: scripter.
	
	self assert: scripter id: #one index: 3.
	self assert: scripter id: #two index: 3.
	
	^ scripter
]

{ #category : #examples }
BlShortcutForwardingHandlerExamples >> scripterOne_increaseOne_showTwo_increaseTwo_disableIncrease_enableIncrease_hideTwo [
	<gtExample>
	| scripter |
	scripter := self scripterOne_increaseOne_showTwo_increaseTwo_disableIncrease_enableIncrease.

	self hideShortcut: scripter.
	self increaseShortcut: scripter.
	
	self assert: scripter id: #one index: 4.
	
	^ scripter
]

{ #category : #examples }
BlShortcutForwardingHandlerExamples >> scripterOne_increaseOne_showTwo_increaseTwo_hideTwo [
	<gtExample>
	| scripter |
	scripter := self scripterOne_increaseOne_showTwo_increaseTwo.

	self hideShortcut: scripter.
	self increaseShortcut: scripter.
	self assert: scripter id: #one index: 3.
	
	^ scripter
]

{ #category : #support }
BlShortcutForwardingHandlerExamples >> showShortcut: scripter [
	scripter shortcut
		combination: (BlKeyCombination builder
				key: BlKeyboardKey s;
				build);
		// #one;
		play
]
