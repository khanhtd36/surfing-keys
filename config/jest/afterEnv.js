const { TextEncoder, TextDecoder } = require('util');
const { toMatchImageSnapshot } = require('jest-image-snapshot');

// jsdom does not expose TextEncoder/TextDecoder, which utils.js needs.
if (typeof global.TextEncoder === 'undefined') {
    global.TextEncoder = TextEncoder;
}
if (typeof global.TextDecoder === 'undefined') {
    global.TextDecoder = TextDecoder;
}

expect.extend({ toMatchImageSnapshot });
