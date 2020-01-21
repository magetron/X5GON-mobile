# Research

## Overview 

Since our main task is to develop an `iOS` application for `X5GON`, it is intuitive to think of the language `Swift` backed by `Apple` (Apple, 2020). Also, `React Native` (Facebook, 2020)  and `Flutter` (Google, 2020) are also viable choices given the recent trend of cross-platform development with `JavaScript`. 

To pick a language or framework for further development, we need to compare them on multiple aspects including but not limited to language, tooling, ease of UI logic development, publishing and packing, framework stability and overall performance.

Hence, the aim of this article is to evaluate and analyse the benefits and drawbacks of using `Swift`, `React Native` and `Flutter`, before attempting to argue that `Swift` will be the most suitable and elegant choice for the project.

## Language

First and foremost, it is important for us to pick a reliable language for our project. An optimal language choice would provide reliable code, eliminate unsafe usages and in the meantime, guarantees simplicity, expressiveness and performance. Therefore, we compare and evaluate `Swift` and `Javascript (ES6+)` in this section, and attempts to draw the conclusion that `Swift` is a more ideal language for our project.

### Background

To provide a background for the context, we will briefly introduce our candidate toolchains, starting with `Swift`. `Swift` is a general-purpose, compiled programming language developed by `Apple Inc.` for all its platforms starting 2014. It is built with the famous `LLVM` compiler framework and is seen as a successor for `Objective-C`, an `Apple`'s variant of `C/C++` language (Timmer, 2014). Compared to its predecessor, it supports many core concepts, e.g. dynamic dispatch (Milton and Schmidt, 1994), widespread late binding (Schrenier, 1994) and extensible programming (Gregory, 2004), in a much safer way. That is, in other words, `Swift` provides safe alternatives to these concepts while addressing common errors, notably null pointer derefercing(Rose, 2017) and undefined callbacks (Apple, 2020).

`Javascript` on the other hand, has much longer history. Starting in 1995, its first announced by NetScape and Sun. (PR Newswire, 1995). Over the years, although `JavaScript` has changed a lot, it still remains a just-in-time compiled, mutli-paradigm programming lanugage that conforms to the spec of `ECMAScript` (IETF Tools, 2006). It has features including but not limited to dynamic typing, prototype-based object orientation, which is dynamic and flexible but might cause issues from time to time (Flanagan, 2011).

### Comparison 

Regarding the aspect of providing reliable and type-safe code, `Javascript` is less preferable than `Swift`, given its weakly dynmaic type systems. For this reason, `Javascript` introduces a lot of representation mismatches and silent type conversions (Jensen et al., 2009), resulting in hard-to-track bugs, which is non-exist in `Swift`. Although unsafe `Swift` can be written dynamically, the safe `Swift` is a strong statically typed language with many modern safety mechanisms, including but not limited to forced wnrapping, fallback variables, mutable / immutable defintions and the forbidden default value of `nil`. On that note, `Swift` does outweight `Javscript` from a robustness perspective.

There are numerous similarities between both `JavaScript` and `Swift` from a syntax perspective, with a couple of examples here at [Folio](https://www.folio3.com/blog/swiftly-javascript-from-javascript-to-apples-swift/) (Folio, 2019). Our team has concluded although differences exists between `Javascript` and `Swift`, the essence remains the asme. As compared to `JavaScript`, `Swift`, as mentioned earlier, provides a lot of advancements in syntax.. Arguably, one might say it can be said that the more features a language provides, the harder it is to program with it. Since then you need to know most of the syntax in order to program effectively (Wirth, 2020). However, from the team's perspective, the lead programmer does come from a `C/C++` background, such that he belives the advancements and syntax sugar of `Swift` would be more helpful writing better software.

Given these reasons, our team picked `Swift` over `Javascript` from a programming language perspective.

## Tooling

As for `Swift` and `iOS` development, its tooling `Xcode IDE` (Apple Developer, 2020) is backed by `Apple`. `React Native` or `Flutter`, in contrast, does have native support but relies on Command-Line-Interface (CLI) of `XcodeBuild` to build the application. However, with that said, one can use `Jetbrains WebStorm` (Jetbrains, 2020) or `VSCode` (Microsoft, 2020) at its convenience thanks to the flexibility `JavaScript` development provides.

### Comparison

From a development perspective, `Swift` is first of all a compiled language, while `JavaScript` is an interpreted language (although most engines currently does Just-in-Time(JIT) compilation instead (Auler et al., 2014)). This is a advantage for `React Native` and `Flutter` as they support hot-reloading during development (Bigio, 2016). It is very efficient as you can see changes instantly in less than 1 second, compared to `Swift` where you have to re-build in about 7 to 8 seconds. 


## References

Timmer, John (June 5, 2014). "A fast look at Swift, Apple's new programming language". Ars Technica. Condé Nast. Retrieved Jan 12, 2020.

Rose, Jordan (Sep 5, 2017). "Make unsafe pointer nullability explict using Optional". Swift 3. Retreived Dec 5, 2019.

Apple (Jan, 2020). "Closures". Swift 5.1. Retrieved Jan 15, 2020.

Milton, Scott; Schmidt, Heinz W. (1994). Dynamic Dispatch in Object-Oriented Languages (Technical report). TR-CS-94-02. Australian National University. CiteSeerX 10.1.1.33.4292.

Gregory V. Wilson (Dec/Jan 2004–2005). "Extensible Programming for the 21st Century". ACM Queue 2 no. 9.

Schreiner, Axel-Tobias (1994). Object-Oriented Programming With ANSI-C (PDF). Munich: Hanser. p. 15. ISBN 3-446-17426-5.

PPR Newswire (Dec 4, 1995). Press release announcing JavaScript, "Netscape and Sun announce JavaScript".

IETF Tools. (2006)."RFC 4329". Archived from the original on 2019-05-27. Retrieved 27 May 2019.

Flanagan, David. (2011). JavaScript - The Definitve Guide ep. 6. Sebastopol: O'Reilly Media.

Jensen S.H., Møller A., Thiemann P. (2009) Type Analysis for JavaScript. In: Palsberg J., Su Z. (eds) Static Analysis. SAS 2009. Lecture Notes in Computer Science, vol 5673. Springer, Berlin, Heidelberg

Wirth, M. (2016). The cognitive load of programming languages on the novice programmer. [online] The Craft of Coding. Available at: https://craftofcoding.wordpress.com/2016/09/14/the-cognitive-load-of-programming-languages-on-the-novice-programmer/ [Accessed 21 Jan. 2020].

Folio (2019). Swiftly JavaScript - From JavaScript to Apple’s Swift - folio3. [online] Available at: https://www.folio3.com/blog/swiftly-javascript-from-javascript-to-apples-swift/ [Accessed 21 Jan. 2020].

Apple Developer. (2020). Xcode - Apple Developer. [online] Available at: https://developer.apple.com/xcode/ [Accessed 21 Jan. 2020].

Auler R., Borin E., de Halleux P., Moskal M., Tillmann N. (2014) Addressing JavaScript JIT Engines Performance Quirks: A Crowdsourced Adaptive Compiler. In: Cohen A. (eds) Compiler Construction. CC 2014. Lecture Notes in Computer Science, vol 8409. Springer, Berlin, Heidelberg

Bigio, M. (2020). Introducing Hot Reloading · React Native. [online] Facebook.github.io. Available at: https://facebook.github.io/react-native/blog/2016/03/24/introducing-hot-reloading.html [Accessed 21 Jan. 2020].

https://developer.apple.com/swift/

https://facebook.github.io/react-native/

https://flutter.dev/
