resource "aws_key_pair" "prasanna-key" {
  key_name   = "prasanna-key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
