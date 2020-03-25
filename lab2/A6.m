%init data
words = ["Anti-aging"; "Customers"; "Fun"; "Groningen"; "Lecture"; "Money"; "Vacation"; "Viagra"; "Watches"]
data = [0.00062, 0.000000035;
0.005, 0.0001;
0.00015, 0.0007;
0.00001, 0.001;
0.000015, 0.0008;
0.002, 0.0005;
0.00025, 0.00014;
0.001, 0.0000003;
0.0003, 0.000004]


%analyze email1
email2 = "Did you have fun on vacation? I sure did!";
email1 = "We offer our dear customers a wide selection of classy watches.";
[numerator, denominator] = spamFilter(email1,words,data);
numerator
denominator