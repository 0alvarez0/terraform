resource "aws_iam_user" "user1" {
  name = "user1"
}

resource "aws_iam_group" "group1" {
  name = var.group
}

resource "aws_iam_user_group_membership" "grpmem" {
  user = aws_iam_user.user1.name
  groups = [ aws_iam_group.group1.name ]
} 
