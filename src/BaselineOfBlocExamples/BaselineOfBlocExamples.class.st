Class {
	#name : #BaselineOfBlocExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocExamples
}

{ #category : #baseline }
BaselineOfBlocExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.662/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:a5e3cadd7fd5998b00ea2d51be79a1fc732fe5ee/repository' ].
		spec
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.185/src' ].
		spec
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.92/src' ].

		spec package: 'Bloc-Text-Examples' with: [
			spec requires: #('Bloc') ].
		spec package: 'Bloc-Layout-Examples' with: [
			spec requires: #('Bloc' 'GToolkitExamplesEngine') ].
		spec package: 'Bloc-Examples' with: [
			spec requires: #('Bloc') ].
		spec package: 'Bloc-Compositor-Examples' with: [
			spec requires: #('Bloc' #'Bloc-Examples') ].
		spec package: 'Bloc-Docs' with: [
			spec requires: #('Bloc') ].
	]
]
