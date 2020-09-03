with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Ada.Command_Line;

procedure Main is

   generator: Natural;
   prime : Natural;
   alicePrivateKey : Natural;
   bobPrivateKey : Natural;

   ---------------------
   -- DecimalToBinary --
   ---------------------

   function DecimalToBinary (N : Natural) return String
   is
      ret : Ada.Strings.Unbounded.Unbounded_String;
   begin

      if N < 2 then
         return "1";

      else
         Ada.Strings.Unbounded.Append(ret, Ada.Strings.Unbounded.To_Unbounded_String(decimalToBinary (N / 2)));
         Ada.Strings.Unbounded.Append(ret, Ada.Strings.Fixed.Trim(Integer'Image(N mod 2), Ada.Strings.Left));

      end if;

      return Ada.Strings.Unbounded.To_String(ret);

   end decimalToBinary;

   -------------------------------
   -- FastModularExponentiation --
   -------------------------------

   function FastModularExponentiation (b, exp, m : Natural) return Integer
   is
      x : Integer := 1;
      power : Integer;
      str : String := DecimalToBinary (exp);
   begin

      power := b mod m;

      for i in 0 .. (str'Length - 1) loop
         if str(str'Last - i) = '1' then
            x := (x * power) mod m;
         end if;

         power := (power*power) mod m;
      end loop;

      return x;

   end FastModularExponentiation;

   -----------
   -- Power --
   -----------

   function Power (privateKey, g, n : Integer) return Integer
   is
   begin

      if privateKey = 1 then
         return 1;
      end if;

      return FastModularExponentiation (g, privateKey, n);

   end Power;

   -------------------
   -- IsPrimeNumber --
   -------------------

   function IsPrimeNumber (N : Natural) return Boolean
   is
      isPrime : Boolean := true;
   begin

      if N = 0 or N = 1 then
         return false;
      end if;

      for i in 1 .. N / 2 loop
         if (N mod (i + 1)) = 0 then
            isPrime := false;
            exit;
         end if;
      end loop;

      return isPrime;

   end IsPrimeNumber;

begin

   Ada.Integer_Text_IO.Default_Width := 0;

    if Ada.Command_Line.Argument_Count < 1 then
      Ada.Text_IO.Put_Line("You forgot to pass in all the arguments! Try --help.");
      return;
   end if;

   if Ada.Command_Line.Argument(1) = "--help" then
      Ada.Text_IO.Put_Line("Argument order: Alice, Bob, Generator, Prime");
      return;
   end if;

   if Ada.Command_Line.Argument_Count < 4 then
      Ada.Text_IO.Put_Line("You forgot to pass in all the arguments! Try --help.");
      return;
   end if;

   alicePrivateKey := Integer'Value(Ada.Command_Line.Argument(1));
   bobPrivateKey := Integer'Value(Ada.Command_Line.Argument(2));
   generator := Integer'Value(Ada.Command_Line.Argument(3));
   prime := Integer'Value(Ada.Command_Line.Argument(4));

   if not IsPrimeNumber (prime) then
      Ada.Integer_Text_IO.Put (prime);
      Ada.Text_IO.Put_Line(" is not a prime number.");
      return;
   end if;

   Ada.Text_IO.Put ("Generator: ");
   Ada.Integer_Text_IO.Put (generator);
   Ada.Text_IO.New_Line;

   Ada.Text_IO.Put ("Prime Number: ");
   Ada.Integer_Text_IO.Put (prime);
   Ada.Text_IO.New_Line;

   Ada.Text_IO.Put ("Alice's Private Key: ");
   Ada.Integer_Text_IO.Put (alicePrivateKey);
   Ada.Text_IO.New_Line;

   Ada.Text_IO.Put ("Bob's Private Key: ");
   Ada.Integer_Text_IO.Put (bobPrivateKey);
   Ada.Text_IO.New_Line;

   Ada.Text_IO.Put ("Alice sends the message ");
   Ada.Integer_Text_IO.Put (Power(alicePrivateKey, generator, prime));
   Ada.Text_IO.Put_Line (" to Bob.");

   Ada.Text_IO.Put ("Bob sends the message ");
   Ada.Integer_Text_IO.Put (Power(bobPrivateKey, generator, prime));
   Ada.Text_IO.Put_Line (" to Alice.");

   Ada.Text_IO.Put ("Alice gets the secret key ");
   Ada.Integer_Text_IO.Put (Power(alicePrivateKey, Power(bobPrivateKey, generator, prime), prime));
   Ada.Text_IO.New_Line;

   Ada.Text_IO.Put ("Bob gets the secret key ");
   Ada.Integer_Text_IO.Put (Power(bobPrivateKey, Power(alicePrivateKey, generator, prime), prime));
   Ada.Text_IO.New_Line;

   null;
end Main;
