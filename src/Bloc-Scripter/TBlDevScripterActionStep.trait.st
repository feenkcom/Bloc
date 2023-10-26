"
I define common action steps.

My users must also use {{gtClass:TBlDevScripterCheckStepCreation}}

"
Trait {
	#name : #TBlDevScripterActionStep,
	#category : #'Bloc-Scripter-Scripter'
}

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> click [
	"Simulates a click event on a target element"
	<scripterActionStep>

	^ self addStep: (BlDevScripterClickStep new referenceSender)
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> clickStep: aBlock [
	| step |
	step := self click.
	aBlock value: step.
	step play
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> do [
	"Performs a block closure with a target element as an argument"
	<scripterActionStep>

	^ self addStep: BlDevScripterActionStep new referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> doStep: aBlock [
	| step |
	step := self do.
	aBlock value: step.
	step play
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> doubleClick [
	"Simulates a double click event on a target element"
	<scripterActionStep>
	
	^ self addStep: (BlDevScripterDoubleClickStep new referenceSender)
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> doubleClickStep: aBlock [
	| step |
	step := self doubleClick.
	aBlock value: step.
	step play
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> fire [
	"Fires an event for a target element"
	<scripterActionStep>

	^ self addStep: BlDevScripterFireEventStep new referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> keyDown [
	"Simulates a keyboard key down event sent to the focused element"
	<scripterActionStep>

	^ self addStep: BlDevScripterKeyDownStep new referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> keyDown: aBlKeyboardKey [
	"Simulates a keyboard key down event sent to the focused element"

	^ self keyDown key: aBlKeyboardKey; referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> keyPress [
	"Simulates a keyboard key click event sent to the focused element"
	<scripterActionStep>

	^ self addStep: BlDevScripterKeyPressStep new referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> keyPress: aBlKeyboardKey [
	"Simulates a keyboard key click event sent to the focused element"

	^ self keyPress key: aBlKeyboardKey; referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> keyPressStep: aBlock [
	| step |
	step := self keyPress.
	aBlock value: step.
	step play
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> keyUp [
	"Simulates a keyboard key up event sent to the focused element"
	<scripterActionStep>

	^ self addStep: BlDevScripterKeyUpStep new referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> keyUp: aBlKeyboardKey [
	"Simulates a keyboard key up event sent to the focused element"

	^ self keyUp key: aBlKeyboardKey; referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> mouseDown [
	"Simulates a mouse down event at the current cursor position"
	<scripterActionStep>

	^ self addStep: (BlDevScripterMouseDownStep new referenceSender)
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> mouseMove [
	"Simulates a mouse move event by a delta distance"
	<scripterActionStep>

	^ self addStep: (BlDevScripterMouseMoveStep new referenceSender)
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> mouseMoveOver [
	"Simulates a mouse over event on the target element"
	<scripterActionStep>

	^ self addStep: (BlDevScripterMouseMoveOverStep new referenceSender)
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> mouseMoveOverStep: aBlock [
	| step |
	step := self mouseMoveOver.
	aBlock value: step.
	step play
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> mouseUp [
	"Simulates a mouse up event at the current cursor position"
	<scripterActionStep>

	^ self addStep: (BlDevScripterMouseUpStep new referenceSender)
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> mouseWheel [
	"Simulates a mouse wheel event on the target element"
	<scripterActionStep>

	^ self addStep: (BlDevScripterMouseWheelStep new referenceSender)
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> requestFocus [
	"Requests focus for the target element"
	<scripterActionStep>

	^ self addStep: BlDevScripterRequestFocusStep new referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> secondaryClick [
	"Simulates a secondary click event on a target element"
	<scripterActionStep>

	^ self addStep: (BlDevScripterSecondaryClickStep new referenceSender)
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> secondaryClickStep: aBlock [
	| step |
	step := self secondaryClick.
	aBlock value: step.
	step play
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> set [
	"Assigns various optional variables in the scripter such as model or key:value pairs"
	<scripterActionStep>

	^ self addStep: BlDevScripterSetStep new referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> shortcut [
	"Simulates a keyboard shortcut event on a target element. If no target
	 element is provided, the shortcut is sent to the scripted element."
	<scripterActionStep>

	^ self addStep: BlDevScripterShortcutStep new referenceSender
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substep: aLabel do: anOneArgBlock [
	^ self substeps: aLabel do: anOneArgBlock
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substeps [
	^ self addStep: (BlDevScripterMultipleActionStep new referenceSender)
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substeps: aLabel [
	^ self substeps
		label: aLabel;
		referenceSender
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substeps: aLabel do: anOneArgBlock [
	| aStep |
	aStep := self substeps
		label: aLabel;
		referenceSender.
	anOneArgBlock value: aStep.
	^ aStep
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> type [
	"Simulates a keyboard input event (text) on a target element"
	<scripterActionStep>

	^ self addStep: BlDevScripterTypeTextStep new referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> type: aString [

	^ self type text: aString; referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> typeStep: aBlock [
	| step |
	step := self type.
	aBlock value: step.
	step play
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> wait [
	^ self addStep: BlDevScripterWaitStep new referenceSender
]
