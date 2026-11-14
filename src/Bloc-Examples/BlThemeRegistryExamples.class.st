"
Examples for lazily registered subthemes without dependencies on a widget package.
"
Class {
	#name : #BlThemeRegistryExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Core-Theme'
}

{ #category : #examples }
BlThemeRegistryExamples >> emptyRegistry [
	<gtExample>
	| theme |
	theme := BlTheme new.
	self assert: theme subThemes isEmpty.
	theme themeModified.
	self assert: theme subThemes isEmpty.
	^ theme
]

{ #category : #examples }
BlThemeRegistryExamples >> independentRegistries [
	<gtExample>
	| first second secondGeneration |
	first := self lazySubTheme.
	second := self lazySubTheme.
	self assert: first subThemes ~~ second subThemes.
	self
		assert: (first subThemes at: #exampleSubTheme)
				~~ (second subThemes at: #exampleSubTheme).
	secondGeneration := second generation.
	first themeModified.
	self assert: second generation = secondGeneration.
	self assert: (first subThemes at: #exampleSubTheme) theme == first.
	self assert: (second subThemes at: #exampleSubTheme) theme == second.
	^ second
]

{ #category : #examples }
BlThemeRegistryExamples >> lazySubTheme [
	<gtExample>
	| theme subtheme again |
	theme := self emptyRegistry.
	subtheme := theme
			subThemeAt: #exampleSubTheme
			ifAbsentPut: [ (BlThemeRegistryExampleSubTheme theme: theme) registryKey: #exampleSubTheme ].
	again := theme
			subThemeAt: #exampleSubTheme
			ifAbsentPut: [ self error: 'An existing subtheme must be reused' ].
	self assert: subtheme == again.
	self assert: subtheme theme == theme.
	^ theme
]

{ #category : #examples }
BlThemeRegistryExamples >> registeredSubThemesRefresh [
	<gtExample>
	| theme subtheme generation |
	theme := self lazySubTheme.
	subtheme := theme subThemes at: #exampleSubTheme.
	generation := theme generation.
	theme themeModified.
	self assert: theme generation = (generation + 1).
	self assert: (theme subThemes at: #exampleSubTheme) == subtheme.
	self assert: subtheme theme == theme.
	^ theme
]

{ #category : #examples }
BlThemeRegistryExamples >> rejectNonSubTheme [
	<gtExample>
	| theme rejected |
	theme := self emptyRegistry.
	rejected := [ theme subThemeAt: #invalid put: Object new.
		false ] on: AssertionFailure do: [ :error | true ].
	self assert: rejected.
	self assert: theme subThemes isEmpty.
	^ theme
]

{ #category : #examples }
BlThemeRegistryExamples >> replaceRegisteredSubTheme [
	<gtExample>
	| theme original replacement |
	theme := self lazySubTheme.
	original := theme subThemes at: #exampleSubTheme.
	replacement := (BlThemeRegistryExampleSubTheme theme: theme)
			registryKey: #exampleSubTheme.
	self
		assert: (theme subThemeAt: #exampleSubTheme put: replacement) == replacement.
	theme themeModified.
	self assert: (theme subThemes at: #exampleSubTheme) == replacement.
	self assert: replacement ~~ original.
	self assert: replacement theme == theme.
	^ theme
]
