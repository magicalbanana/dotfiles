# Golang Convention

## Documentation

- You will use the `//` comment style for all comments.
- You will provide the reason for a function, focusing on the why and not the how.
- You will provide documentation to interfaces, structs, constants, variables, and function types.
- You will provide documentation to of the methods for an interface type.
- You will provide documentation to the concrete implementation of an interface type even if it is not exported.
- You will provide examples when necessary.
- You will provide the return values and their types.
- You will provide the error return value if the function returns an error.
- You will provide the exported functions in the package's documentation.
- You will provide the package's on a separate doc.go file within the package.
- You will provide examples in the package's documentation.
- You will provide an example for each exported function.
- You will provide a list of all exported functions.

## Testing

- You will use table driven testing as a pattern for writing tests.
- You will use github.com/stretchr/testify for assertions, preferrably the require package.
- You will write tests for all exported functions.
- When working with interface implementations, you will test the concrete type's functions regardless if the concrete type is unexported. The only exception is avoid testing private or unexported functions.
- You will avoid mocking as much as possible. If you need to mock, you will voice your concerns to discuss the best way to avoid it. Skipping the implementation of that test.
